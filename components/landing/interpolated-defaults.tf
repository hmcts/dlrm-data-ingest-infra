locals {
  is_prod                = length(regexall(".*(prod).*", var.env)) > 0
  is_sbox                = length(regexall(".*(s?box).*", var.env)) > 0
  ssptl_sub_id           = local.is_sbox ? "64b1c6d6-1481-44ad-b620-d8fe26a2c768" : "6c4d2513-a873-41b4-afdd-b05a33206631"
  cftptl_sub_id          = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
  soc_sub_id             = "8ae5b3b6-0b12-4888-b894-4cec33c92292"
  cnp_prod_sub_id        = "8999dec3-0104-4a27-94ee-6588559729d1"
  cnp_nonprod_sub_id     = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
  users_set              = toset([for principal in var.rbac_principals : principal if lower(principal.type) == "user"])
  groups_set             = toset([for principal in var.rbac_principals : principal if lower(principal.type) == "group"])
  service_principals_set = toset([for principal in var.rbac_principals : principal if lower(principal.type) == "service principal"])
}

module "ctags" {
  source = "github.com/hmcts/terraform-module-common-tags"

  builtFrom    = var.builtFrom
  environment  = var.env
  product      = var.product
  expiresAfter = "3000-01-01"
}

data "azuread_user" "principal" {
  for_each            = local.users_set
  user_principal_name = each.value.name
  mail                = each.value.mail
}

data "azuread_group" "principal" {
  for_each         = local.groups_set
  display_name     = each.value.name
  mail_nickname    = each.value.mail
  security_enabled = true
}

data "azuread_service_principal" "principal" {
  for_each     = local.service_principals_set
  display_name = each.value.name
}
