resource "azurerm_role_assignment" "blob_reader_from_cognitive_account" {
  scope                = module.storage.storageaccount_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = module.ai.cognitive_account_identity
}

resource "azurerm_role_assignment" "blob_reader_from_ai_foundry" {
  scope                = module.storage.storageaccount_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = module.ai.ai_foundry_identity
}

resource "azurerm_role_assignment" "blob_reader_from_ml_workspace" {
  scope                = module.storage.storageaccount_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = module.ai.ml_workspace_identity
}