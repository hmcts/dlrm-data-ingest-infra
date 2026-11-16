# The SMB mount failure alert for the doc migration VM is now managed by hmcts/dlrm-aria-doc-migration-iac.
# These blocks drop it from this component's state without destroying it; they can be deleted once applied.

removed {
  from = azurerm_monitor_action_group.smb_mount_failures_slack

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_scheduled_query_rules_alert_v2.smb_mount_failures

  lifecycle {
    destroy = false
  }
}
