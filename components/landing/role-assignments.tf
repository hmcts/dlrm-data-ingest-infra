resource "azurerm_role_assignment" "users" {
  for_each             = setproduct(local.users_set, [for lz_key in keys(var.landing_zones) : module.data_landing_zone[lz_key].resource_groups])
  scope                = module.data_landing_zone[each.value[1]].resource_groups
  role_definition_name = "Owner"
  principal_id         = data.azuread_user.principal[each.value[0]].id
}

resource "azurerm_role_assignment" "groups" {
  for_each             = setproduct(local.groups_set, [for lz_key in keys(var.landing_zones) : module.data_landing_zone[lz_key].resource_groups])
  scope                = each.value[1]
  role_definition_name = "Owner"
  principal_id         = data.azuread_user.principal[each.value[0]].id
}

resource "azurerm_role_assignment" "service_principals" {
  for_each             = setproduct(local.service_principals_set, [for lz_key in keys(var.landing_zones) : module.data_landing_zone[lz_key].resource_groups])
  scope                = each.value[1]
  role_definition_name = "Owner"
  principal_id         = data.azuread_user.principal[each.value[0]].id
}
