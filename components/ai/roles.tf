resource "azurerm_role_assignment" "poc_group" {

  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.poc_group.object_id

}