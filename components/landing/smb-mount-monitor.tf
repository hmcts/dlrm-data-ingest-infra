locals {
  smb_mount_monitor_alert_enabled = var.smb_mount_monitor_alert.enabled && length(var.smb_mount_monitor_alert.action_group_ids) > 0
}

check "smb_mount_monitor_alert_computer_name" {
  assert {
    condition     = !var.smb_mount_monitor_alert.enabled || var.smb_mount_monitor_alert.computer_name != null
    error_message = "smb_mount_monitor_alert.computer_name must be set when smb_mount_monitor_alert.enabled is true."
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "smb_mount_failures" {
  for_each = local.smb_mount_monitor_alert_enabled ? { primary = var.smb_mount_monitor_alert } : {}

  name                = "${each.value.computer_name}-smb-mount-failures-${var.env}"
  resource_group_name = coalesce(each.value.resource_group_name, module.data_landing_zone[each.value.landing_zone_key].log_analytics_workspace.resource_group_name)
  location            = module.data_landing_zone[each.value.landing_zone_key].log_analytics_workspace.location
  scopes              = [module.data_landing_zone[each.value.landing_zone_key].log_analytics_workspace.id]
  description         = "Repeated SMB/CIFS mount health-check failures on ${each.value.computer_name}."
  severity            = 2
  enabled             = true

  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"

  criteria {
    query                   = <<-KQL
      Syslog
      | where Computer =~ "${each.value.computer_name}"
      | where ProcessName =~ "smb-mount-monitor"
      | where SyslogMessage startswith "SMB_MOUNT_"
      | where not(SyslogMessage startswith "SMB_MOUNT_MONITOR_TEST")
    KQL
    time_aggregation_method = "Count"
    operator                = "GreaterThanOrEqual"
    threshold               = 2
  }

  action {
    action_groups = each.value.action_group_ids
  }

  tags = merge(module.ctags.common_tags, local.auto_shutdown_common_tags, each.value.tags)
}
