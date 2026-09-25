resource "azurerm_recovery_services_vault" "this" {
  name                = "ingest-mgmt-rsv-${var.env}"
  location            = module.data_mgmt_zone.location
  resource_group_name = module.data_mgmt_zone.resource_group_name
  sku                 = "Standard"
  tags                = module.ctags.common_tags
}

resource "azurerm_backup_policy_vm" "daily" {
  name                = "ingest-mgmt-vm-daily-${var.env}"
  resource_group_name = module.data_mgmt_zone.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.this.name
  # V2 is the Enhanced policy, required for Trusted Launch VMs (legacy DB VMs)
  policy_type         = "V2"

  backup {
    frequency = "Daily"
    time      = var.vm_backup_schedule_time
  }

  retention_daily {
    count = var.vm_backup_retention_days
  }
}
