locals {
  is_sbox                   = length(regexall(".*(s?box).*", var.env)) > 0
  ssptl_sub_id              = local.is_sbox ? "64b1c6d6-1481-44ad-b620-d8fe26a2c768" : "6c4d2513-a873-41b4-afdd-b05a33206631"
  ssptl_vnet_name           = local.is_sbox ? "ss-ptlsbox-vnet" : "ss-ptl-vnet"
  ssptl_route_table_name    = local.is_sbox ? "aks-ptlsbox-route-table" : "aks-ptl-route-table"
  ssptl_vnet_resource_group = local.is_sbox ? "ss-ptlsbox-network-rg" : "ss-ptl-network-rg"
  landing_zone_prefixes = flatten([
    for landing_zone in var.landing_zones : landing_zone.address_space
  ])
}

module "ctags" {
  source = "github.com/hmcts/terraform-module-common-tags"

  builtFrom   = var.builtFrom
  environment = var.env
  product     = var.product
}

data "azurerm_route_table" "ssptl" {
  name                = local.ssptl_route_table_name
  resource_group_name = local.ssptl_vnet_resource_group
}
