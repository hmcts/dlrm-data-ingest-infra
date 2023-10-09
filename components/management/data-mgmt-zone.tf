module "data_mgmt_zone" {
  source = "github.com/hmcts/terraform-module-data-management-zone?ref=main"

  providers = {
    azurerm     = azurerm,
    azurerm.hub = azurerm.hub
  }

  env                       = var.env
  common_tags               = module.ctags.common_tags
  default_route_next_hop_ip = var.default_route_next_hop_ip
  address_space             = var.mgmt_address_space
  hub_vnet_name             = var.hub_vnet_name
  hub_resource_group_name   = var.hub_resource_group_name
}
