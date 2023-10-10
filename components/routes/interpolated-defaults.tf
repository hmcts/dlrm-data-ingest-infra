locals {
  ssptl_sub_id       = "6c4d2513-a873-41b4-afdd-b05a33206631"
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
  name                = "aks-ptl-route-table"
  resource_group_name = "ss-ptl-network-rg"
}
