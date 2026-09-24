data "azurerm_subscription" "current" {}

locals {
  backup_resource_group_name = "ingest-mgmt-rg-${var.env}"
  backup_vault_name          = "ingest-mgmt-rsv-${var.env}"
  backup_policy_name         = "ingest-mgmt-vm-daily-${var.env}"
  backup_policy_id           = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.backup_resource_group_name}/providers/Microsoft.RecoveryServices/vaults/${local.backup_vault_name}/backupPolicies/${local.backup_policy_name}"

  legacy_database_vms = {
    for pair in flatten([
      for lz_key, zone in var.landing_zones : [
        for db_key in keys(zone.legacy_databases) : {
          key        = "${lz_key}-${db_key}"
          lz         = lz_key
          db         = db_key
          use_ip_kit = zone.use_microsoft_ip_kit_structure
        }
      ]
    ]) : pair.key => pair
  }

  legacy_database_vm_ids = {
    for key, vm in local.legacy_database_vms : key =>
    "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/ingest${vm.lz}-${vm.use_ip_kit ? "main" : "metadata"}-${var.env}/providers/Microsoft.Compute/virtualMachines/ingest${vm.lz}-${vm.db}-${var.env}"
  }
}

resource "azurerm_backup_protected_vm" "legacy_database" {
  for_each            = local.legacy_database_vms
  resource_group_name = local.backup_resource_group_name
  recovery_vault_name = local.backup_vault_name
  source_vm_id        = local.legacy_database_vm_ids[each.key]
  backup_policy_id    = local.backup_policy_id

  # source_vm_id is a string-built ARM ID, so there is no implicit graph edge to the
  # VMs created by the landing zone module; enforce ordering so enrollment only
  # happens after the VMs exist.
  depends_on = [module.data_landing_zone]
}
