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
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox"
  to = module.data_landing_zone["05"].azurerm_resource_group.this["main"]
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.Compute/virtualMachines/ingest05-legacy-sql-sbox/extensions/AMALinux"
  to = module.data_landing_zone["05"].module.legacy_database["legacy-sql"].module.vm-bootstrap[0].azurerm_virtual_machine_extension.azure_monitor[0]
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.Compute/virtualMachines/ingest05-legacy-sql-sbox/extensions/HMCTSVMBootstrap"
  to = module.data_landing_zone["05"].module.legacy_database["legacy-sql"].module.vm-bootstrap[0].azurerm_virtual_machine_extension.custom_script[0]
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.KeyVault/vaults/ingest05-logging-sbox"
  to = module.data_landing_zone["05"].module.logging_vault.azurerm_key_vault.kv
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.KeyVault/vaults/ingest05-meta001-sbox/objectId/e7ea2042-4ced-45dd-8ae3-e051c6551789"
  to = module.data_landing_zone["05"].module.metadata_vault["meta001"].azurerm_key_vault_access_policy.product_team_access_policy
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.KeyVault/vaults/ingest05-meta002-sbox/objectId/e7ea2042-4ced-45dd-8ae3-e051c6551789"
  to = module.data_landing_zone["05"].module.metadata_vault["meta002"].azurerm_key_vault_access_policy.product_team_access_policy
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.Databricks/workspaces/ingest05-integration-databricks001-sbox"
  to = module.data_landing_zone["05"].module.shared_integration_databricks.azurerm_databricks_workspace.this
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.Databricks/workspaces/ingest05-product-databricks001-sbox"
  to = module.data_landing_zone["05"].module.shared_product_databricks.azurerm_databricks_workspace.this
}
import {
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-main-sbox/providers/Microsoft.KeyVault/vaults/ingest05-meta001-sbox/objectId/59bab40b-0894-4faf-9f92-0f627108107a"
  to = module.data_landing_zone["05"].module.metadata_vault["meta001"].azurerm_key_vault_access_policy.creator_access_policy
}

