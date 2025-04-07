resource "azuread_group" "poc_group" {
  display_name     = "POC Group"
  mail_enabled     = false
  security_enabled = true
  owners           = [data.azuread_user.user.object_id]
  members          = [data.azuread_user.user.object_id]
}

resource "azurerm_role_assignment" "poc_group" {

  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.poc_group.object_id

}