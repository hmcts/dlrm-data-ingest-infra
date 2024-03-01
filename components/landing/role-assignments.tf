resource "azurerm_role_assignment" "roles" {
  for_each             = { for rbac in local.flattened_rbac : rbac.key => rbac }
  scope                = each.value.scope
  role_definition_name = each.value.role
  principal_id         = lower(each.value.type) == "user" ? data.azuread_user.principal[each.key].object_id : lower(each.value.type) == "group" ? data.azuread_group.principal[each.key].object_id : data.azuread_service_principal.principal[each.key].object_id
}
