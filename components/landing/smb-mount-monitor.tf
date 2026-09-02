locals {
  smb_mount_monitor_alert_enabled = var.smb_mount_monitor_alert.enabled && var.smb_mount_monitor_alert.slack_webhook_vault_id != null && var.smb_mount_monitor_alert.slack_webhook_secret_name != null
}

data "azurerm_key_vault_secret" "smb_mount_slack_webhook" {
  count        = local.smb_mount_monitor_alert_enabled ? 1 : 0
  key_vault_id = var.smb_mount_monitor_alert.slack_webhook_vault_id
  name         = var.smb_mount_monitor_alert.slack_webhook_secret_name
}

check "smb_mount_monitor_alert_computer_name" {
  assert {
    condition     = !var.smb_mount_monitor_alert.enabled || var.smb_mount_monitor_alert.computer_name != null
    error_message = "smb_mount_monitor_alert.computer_name must be set when smb_mount_monitor_alert.enabled is true."
  }
}

check "smb_mount_monitor_alert_webhook_vault_id" {
  assert {
    condition     = !var.smb_mount_monitor_alert.enabled || var.smb_mount_monitor_alert.slack_webhook_vault_id != null
    error_message = "smb_mount_monitor_alert.slack_webhook_vault_id must be set when smb_mount_monitor_alert.enabled is true."
  }
}

check "smb_mount_monitor_alert_webhook_secret_name" {
  assert {
    condition     = !var.smb_mount_monitor_alert.enabled || var.smb_mount_monitor_alert.slack_webhook_secret_name != null
    error_message = "smb_mount_monitor_alert.slack_webhook_secret_name must be set when smb_mount_monitor_alert.enabled is true."
  }
}

resource "azurerm_monitor_action_group" "smb_mount_failures_slack" {
  for_each = local.smb_mount_monitor_alert_enabled ? { primary = var.smb_mount_monitor_alert } : {}

  name                = "${each.value.computer_name}-smb-mount-failures-ag-${var.env}"
  resource_group_name = coalesce(each.value.resource_group_name, module.data_landing_zone[each.value.landing_zone_key].log_analytics_workspace.resource_group_name)
  location            = "global"
  short_name          = "smb-mount"

  webhook_receiver {
    name                    = "slack"
    service_uri             = data.azurerm_key_vault_secret.smb_mount_slack_webhook[0].value
    use_common_alert_schema = true
  }

  tags = merge(module.ctags.common_tags, local.auto_shutdown_common_tags, each.value.tags)
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
    action_groups = [azurerm_monitor_action_group.smb_mount_failures_slack[each.key].id]
  }

  tags = merge(module.ctags.common_tags, local.auto_shutdown_common_tags, each.value.tags)
}
