import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.Compute/virtualMachines/ingest05-legacy-sql-sbox"
  to = module.data_landing_zone["05"].module.legacy_database["legacy-sql"].azurerm_linux_virtual_machine.linvm[0]
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.Network/networkInterfaces/ingest05-legacy-sql-nic-sbox"
  to = module.data_landing_zone["05"].module.legacy_database["legacy-sql"].azurerm_network_interface.vm_nic
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.KeyVault/vaults/ingest05-meta001-sbox"
  to = module.data_landing_zone["05"].module.metadata_vault["meta001"].azurerm_key_vault.kv
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.KeyVault/vaults/ingest05-meta002-sbox"
  to = module.data_landing_zone["05"].module.metadata_vault["meta002"].azurerm_key_vault.kv
}
