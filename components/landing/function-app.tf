module "function_app" {
  source   = "./../../modules/function_app"
  for_each = { for lz_key, lz in var.landing_zones : lz_key => lz if lz.deploy_function_app }
  providers = {
    azurerm        = azurerm
    azurerm.ssptl  = azurerm.ssptl
    azurerm.cftptl = azurerm.cftptl
  }
  env                        = var.env
  landing_zone_key           = each.key
  resource_group_name        = [for rg in module.data_landing_zone[each.key].resource_groups : rg.name if strcontains(rg.name, "logic")][0]
  common_tags                = merge(module.ctags.common_tags, { "Data-Ingest-Project" = each.value.project })
  function_app_subnet_id     = module.data_landing_zone[each.key].subnet_ids["vnet-function-app"]
  private_endpoint_subnet_id = module.data_landing_zone[each.key].subnet_ids["vnet-services"]
}
