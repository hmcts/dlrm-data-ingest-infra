resource "azurerm_role_assignment" "poc_group" {

  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.poc_group.object_id

}

resource "azurerm_role_assignment" "poc_group_sa_blob_contributor" {

  scope                = data.azurerm_storage_account.ingest_storage_account.id
  role_definition_name = "Storage Account Data Contributor"
  principal_id         = data.azuread_group.poc_group.object_id

}

resource "azurerm_role_assignment" "poc_group_sa_contributor" {

  scope                = data.azurerm_storage_account.ingest_storage_account.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.poc_group.object_id

}