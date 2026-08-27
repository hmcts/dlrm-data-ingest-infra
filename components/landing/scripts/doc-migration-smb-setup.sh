#!/bin/bash
set -euo pipefail

# Log file for debugging
LOG_FILE="/var/log/smb-mount-setup.log"
echo "Starting SMB mount configuration at $(date)" | tee -a "$LOG_FILE"

# Update system and install dependencies
echo "Installing dependencies..." | tee -a "$LOG_FILE"
apt-get update
apt-get install -y cifs-utils nfs-common curl jq 2>&1 | tee -a "$LOG_FILE"

# Get access token using managed identity
echo "Retrieving access token from managed identity..." | tee -a "$LOG_FILE"
ACCESS_TOKEN=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2017-12-01&resource=https%3A%2F%2Fvault.azure.net" | jq -r '.access_token')

if [ -z "$ACCESS_TOKEN" ] || [ "$ACCESS_TOKEN" = "null" ]; then
  echo "ERROR: Failed to obtain managed identity token" | tee -a "$LOG_FILE"
  exit 1
fi

# Retrieve SMB mount configuration from Key Vault
echo "Retrieving SMB mount configuration from Key Vault..." | tee -a "$LOG_FILE"
# Replace KEYVAULT_NAME with your actual Key Vault name
KEYVAULT_NAME="ingest00-meta002-prod"
KEYVAULT_URL="https://${KEYVAULT_NAME}.vault.azure.net"

# Retrieve mount config secret
MOUNT_CONFIG=$(curl -s -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  "${KEYVAULT_URL}/secrets/doc-migration-smb-mounts?api-version=2016-10-01" | jq -r '.value')

if [ -z "$MOUNT_CONFIG" ] || [ "$MOUNT_CONFIG" = "null" ]; then
  echo "ERROR: Failed to retrieve mount configuration from Key Vault" | tee -a "$LOG_FILE"
  echo "Please ensure secret 'doc-migration-smb-mounts' exists in ${KEYVAULT_NAME}" | tee -a "$LOG_FILE"
  exit 1
fi

# Retrieve SMB credentials from Key Vault
echo "Retrieving SMB credentials from Key Vault..." | tee -a "$LOG_FILE"
SMB_USERNAME=$(curl -s -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  "${KEYVAULT_URL}/secrets/doc-migration-smb-username?api-version=2016-10-01" | jq -r '.value')
SMB_PASSWORD=$(curl -s -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  "${KEYVAULT_URL}/secrets/doc-migration-smb-password?api-version=2016-10-01" | jq -r '.value')
SMB_DOMAIN=$(curl -s -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  "${KEYVAULT_URL}/secrets/doc-migration-smb-domain?api-version=2016-10-01" | jq -r '.value')

if [ -z "$SMB_USERNAME" ] || [ "$SMB_USERNAME" = "null" ]; then
  echo "ERROR: Failed to retrieve SMB credentials from Key Vault" | tee -a "$LOG_FILE"
  exit 1
fi

# Create credentials file from Key Vault secrets
cat > /root/.smb-credentials <<EOC
username=$SMB_USERNAME
password=$SMB_PASSWORD
domain=$SMB_DOMAIN
EOC
chmod 600 /root/.smb-credentials
echo "SMB credentials file created" | tee -a "$LOG_FILE"

# Parse and configure mounts from Key Vault secret
echo "Parsing mount configuration and creating mount points..." | tee -a "$LOG_FILE"

# Mount configuration should be JSON format: {"mounts": [{"unc": "\\\\ip\\share", "mountpoint": "/path", "hostname": "hostname", "ip": "ip.ip.ip.ip"}]}
MOUNT_POINTS=$(echo "$MOUNT_CONFIG" | jq -r '.mounts[] | "\(.unc)|\(.mountpoint)"')

# The health-check reads this file rather than embedding mount points in its
# code.  Keeping it alongside the mount configuration means a bootstrap rerun
# updates both the fstab entries and the set of monitored mounts.
install -d -m 0755 /etc/smb-mount-monitor
printf '%s\n' "$MOUNT_CONFIG" | jq -r '.mounts[]?.mountpoint' > /etc/smb-mount-monitor/mountpoints
if [ ! -s /etc/smb-mount-monitor/mountpoints ]; then
  echo "ERROR: SMB mount configuration contains no mount points" | tee -a "$LOG_FILE"
  exit 1
fi
chmod 0644 /etc/smb-mount-monitor/mountpoints

# First, configure /etc/hosts entries
echo "Configuring /etc/hosts entries..." | tee -a "$LOG_FILE"
HOSTS_ENTRIES=$(echo "$MOUNT_CONFIG" | jq -r '.hosts[] | "\(.ip) \(.hostname)"' | sort -u)
while IFS= read -r host_entry; do
  if [ -n "$host_entry" ]; then
    IP=$(echo "$host_entry" | awk '{print $1}')
    HOSTNAME=$(echo "$host_entry" | awk '{print $2}')
    
    if grep -q "^${IP}[[:space:]]" /etc/hosts; then
      sed -i "s/^${IP}.*/$host_entry/" /etc/hosts
      echo "Updated hosts entry: $host_entry" | tee -a "$LOG_FILE"
    else
      echo "$host_entry" >> /etc/hosts
      echo "Added hosts entry: $host_entry" | tee -a "$LOG_FILE"
    fi
  fi
done <<< "$HOSTS_ENTRIES"

# Configure SMB mounts
echo "Creating SMB mount directories and configuring fstab..." | tee -a "$LOG_FILE"
while IFS='|' read -r unc mountpoint; do
  if [ -n "$unc" ] && [ -n "$mountpoint" ]; then
    # Create mount directory
    mkdir -p "$mountpoint" 2>&1 | tee -a "$LOG_FILE"
    chmod 755 "$mountpoint"

    # Add to fstab if not already present
    if ! grep -q "$(echo "$unc" | sed 's/[\/&]/\\&/g')" /etc/fstab; then
      echo "# SMB Mount: $unc" >> /etc/fstab
      echo "$unc $mountpoint cifs credentials=/root/.smb-credentials,uid=1000,gid=1000,file_mode=0755,dir_mode=0755,noperm 0 0" >> /etc/fstab
      echo "Added fstab entry for $mountpoint" | tee -a "$LOG_FILE"
    fi
  fi
done <<< "$MOUNT_POINTS"

# Mount all shares
echo "Mounting all SMB shares..." | tee -a "$LOG_FILE"
mount -a 2>&1 | tee -a "$LOG_FILE" || echo "WARNING: Some mounts may have failed. Check logs." | tee -a "$LOG_FILE"

# Install the mount health monitor.  It intentionally logs only failures at
# local0.err because the associated DCR only collects Error-and-higher events
# from local0.  A per-mount timeout prevents an unreachable CIFS server from
# making the systemd service run indefinitely.
install -d -m 0755 /usr/local/sbin
cat > /usr/local/sbin/smb-mount-monitor <<'EOF'
#!/bin/bash
set -u -o pipefail

readonly CONFIG_FILE="/etc/smb-mount-monitor/mountpoints"
readonly LOGGER="/usr/bin/logger"
readonly MOUNTPOINT="/usr/bin/mountpoint"
readonly FINDMNT="/usr/bin/findmnt"
readonly TIMEOUT="/usr/bin/timeout"
readonly STAT="/usr/bin/stat"

log_failure() {
  local failure_code="$1"
  local monitored_mount="$2"
  "$LOGGER" -p local0.err -t smb-mount-monitor \
    "${failure_code} mount=${monitored_mount}"
}

if [[ ! -r "$CONFIG_FILE" ]]; then
  # This is deliberately a monitor failure rather than silently succeeding:
  # without its configuration no mount can be checked.
  log_failure SMB_MOUNT_MONITOR_CONFIG_MISSING "$CONFIG_FILE"
  exit 0
fi

monitored_mount=""
while IFS= read -r monitored_mount || [[ -n "$monitored_mount" ]]; do
  # Allow comments and blank lines should the configuration be maintained by
  # hand in addition to the bootstrap process.
  [[ -z "$monitored_mount" || "$monitored_mount" == \#* ]] && continue

  if ! "$MOUNTPOINT" -q -- "$monitored_mount"; then
    log_failure SMB_MOUNT_NOT_MOUNTED "$monitored_mount"
    continue
  fi

  filesystem_type=$("$FINDMNT" --noheadings --output FSTYPE --target "$monitored_mount" 2>/dev/null | tr -d '[:space:]')
  if [[ "$filesystem_type" != "cifs" ]]; then
    log_failure SMB_MOUNT_WRONG_FSTYPE "$monitored_mount"
    continue
  fi

  if ! "$TIMEOUT" --foreground 10s "$STAT" -- "$monitored_mount" >/dev/null 2>&1; then
    log_failure SMB_MOUNT_UNRESPONSIVE "$monitored_mount"
  fi
done < "$CONFIG_FILE"

# Syslog failure records, rather than a failed unit result, are the alerting
# contract.  This lets every configured mount be checked in one invocation.
exit 0
EOF
chmod 0755 /usr/local/sbin/smb-mount-monitor

cat > /etc/systemd/system/smb-mount-monitor.service <<'EOF'
[Unit]
Description=SMB/CIFS mount health check
After=local-fs.target

[Service]
Type=oneshot
ExecStart=/usr/local/sbin/smb-mount-monitor
TimeoutStartSec=2min
NoNewPrivileges=true
PrivateTmp=true
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectControlGroups=true
RestrictAddressFamilies=AF_UNIX
EOF

cat > /etc/systemd/system/smb-mount-monitor.timer <<'EOF'
[Unit]
Description=Run SMB/CIFS mount health check every two minutes

[Timer]
OnBootSec=2min
OnUnitActiveSec=2min
AccuracySec=15s
RandomizedDelaySec=15s
Persistent=true
Unit=smb-mount-monitor.service

[Install]
WantedBy=timers.target
EOF

systemctl daemon-reload
systemctl enable --now smb-mount-monitor.timer

echo "SMB mount configuration complete at $(date)" | tee -a "$LOG_FILE"
echo "Mount status:" | tee -a "$LOG_FILE"
mount | grep cifs | tee -a "$LOG_FILE"
