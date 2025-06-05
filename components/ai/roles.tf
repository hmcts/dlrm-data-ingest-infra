resource "azurerm_role_assignment" "poc_group" {

  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.poc_group.object_id

}

resource "azurerm_role_assignment" "blob_contributor_from_compute_instance" {
  for_each             = module.ai.compute_instance_identity
  scope                = data.azurerm_storage_account.ingest_storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "sa_contributor_from_compute_instance" {
  for_each = module.ai.compute_instance_identity

  scope                = data.azurerm_storage_account.ingest_storage_account.id
  role_definition_name = "Contributor"
  principal_id         = each.value
}