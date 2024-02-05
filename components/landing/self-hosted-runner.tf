resource "azurerm_container_group" "runner" {
  for_each            = var.landing_zones
  name                = "ingest${each.key}-runner-${var.env}"
  location            = "uksouth"
  resource_group_name = module.data_landing_zone[each.key].resource_groups["management"].name
  os_type             = "Linux"
  ip_address_type     = "Private"
  subnet_ids          = [module.data_landing_zone[each.key].subnet_ids["vnet-services"]]
  container {
    name   = "runner"
    image  = "hmctspublic.azurecr.io/github-runner:prod-84d74135-1707147900"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = merge(module.ctags.common_tags, { "Data-Ingest-Project" = each.value.project })
}
