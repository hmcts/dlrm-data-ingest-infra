resource "azurerm_role_assignment" "users" {
  for_each             = setproduct(locals.users_set, local.rbac_scopes)
  scope                = each.value[1]
  role_definition_name = "Owner"
  principal_id         = data.azuread_user.principal[each.value[0]].id
}

resource "azurerm_role_assignment" "groups" {
  for_each             = setproduct(locals.groups_set, local.rbac_scopes)
  scope                = each.value[1]
  role_definition_name = "Owner"
  principal_id         = data.azuread_user.principal[each.value[0]].id
}

resource "azurerm_role_assignment" "service_principals" {
  for_each             = setproduct(locals.service_principals_set, local.rbac_scopes)
  scope                = each.value[1]
  role_definition_name = "Owner"
  principal_id         = data.azuread_user.principal[each.value[0]].id
}
