resource "azurerm_role_assignment" "storage" {
  principal_id         = azurerm_logic_app_standard.this.identity.principal_id
  scope                = module.storage.storageaccount_id
  role_definition_name = "Storage Blob Data Contributor"
}
