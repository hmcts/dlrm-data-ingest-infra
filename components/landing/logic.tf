module "logic" {
  source   = "./../../modules/ipkit_logic"
  for_each = var.landing_zones
  providers = {
    azurerm        = azurerm
    azurerm.ssptl  = azurerm.ssptl
    azurerm.cftptl = azurerm.cftptl
  }
  env                        = var.env
  landing_zone_key           = each.value.lz_key
  resource_group_name        = module.landing_zone[each.key].resource_groups["logic"].name
  common_tags                = merge(module.ctags.common_tags, { "Data-Ingest-Project" = each.value.project })
  private_endpoint_subnet_id = module.landing_zone[each.key].subnet_ids["vnet-services"]
  logicapp_subnet_id         = module.landing_zone[each.key].subnet_ids["vnet-data-product-001"]
}
