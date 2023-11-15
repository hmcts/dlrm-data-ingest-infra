locals {
  is_prod            = length(regexall(".*(prod).*", var.env)) > 0
  is_sbox            = length(regexall(".*(s?box).*", var.env)) > 0
  ssptl_sub_id       = local.is_sbox ? "64b1c6d6-1481-44ad-b620-d8fe26a2c768" : "6c4d2513-a873-41b4-afdd-b05a33206631"
  cftptl_sub_id      = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
  soc_sub_id         = "8ae5b3b6-0b12-4888-b894-4cec33c92292"
  cnp_prod_sub_id    = "8999dec3-0104-4a27-94ee-6588559729d1"
  cnp_nonprod_sub_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
  flattened_rbac = flatten([
    for lz_key, lz in var.landing_zones : [
      for rg in module.data_landing_zone[lz_key].resource_groups : [
        for rbac in lz.role_based_access_control : {
          lz_key = lz_key
          key    = "${lz_key}-${rg.name}-${rbac.type}-${rbac.name == null ? "" : rbac.name}${rbac.mail == null ? "" : rbac.mail}"
          name   = rbac.name
          type   = rbac.type
          mail   = rbac.mail
          role   = rbac.role
          scope  = rg.id
        }
      ]
    ]
  ])
  users                     = { for rbac in local.flattened_rbac : rbac.key => rbac if lower(rbac.type) == "user" }
  groups                    = { for rbac in local.flattened_rbac : rbac.key => rbac if lower(rbac.type) == "group" }
  service_principals        = { for rbac in local.flattened_rbac : rbac.key => rbac if lower(rbac.type) == "service principal" }
  data_ingest_address_space = "10.247.0.0/18"
  subnet_starting_index = {
    "sbox" = 3
    "stg"  = 33
    "prod" = 63
  }
}

module "ctags" {
  source = "github.com/hmcts/terraform-module-common-tags"

  builtFrom    = var.builtFrom
  environment  = var.env
  product      = var.product
  expiresAfter = "3000-01-01"
}

data "azuread_user" "principal" {
  for_each            = local.users
  user_principal_name = endswith(each.value.name, "@justice.gov.uk") ? replace(each.value.name, "@justice.gov.uk", "_justice.gov.uk#EXT#@CJSCommonPlatform.onmicrosoft.com") : each.value.name
  mail                = each.value.mail
}

data "azuread_group" "principal" {
  for_each         = local.groups
  display_name     = each.value.name
  mail_nickname    = each.value.mail
  security_enabled = true
}

data "azuread_service_principal" "principal" {
  for_each     = local.service_principals
  display_name = each.value.name
}
