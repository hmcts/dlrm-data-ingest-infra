module "logic" {
  source   = "./../../modules/ipkit_logic"
  for_each = var.landing_zones
  providers = {
    azurerm        = azurerm
    azurerm.ssptl  = azurerm.ssptl
    azurerm.cftptl = azurerm.cftptl
  }
  env                        = var.env
  landing_zone_key           = each.key
  resource_group_name        = "ingest${each.key}-logic-${var.env}"
  common_tags                = merge(module.ctags.common_tags, { "Data-Ingest-Project" = each.value.project })
  private_endpoint_subnet_id = module.data_landing_zone[each.key].subnet_ids["vnet-services"]
  logicapp_subnet_id         = module.data_landing_zone[each.key].subnet_ids["vnet-data-product-001"]
}
