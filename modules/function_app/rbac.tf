resource "azurerm_role_assignment" "storage" {
  principal_id         = azurerm_linux_function_app.this.identity[0].principal_id
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Contributor"
}
