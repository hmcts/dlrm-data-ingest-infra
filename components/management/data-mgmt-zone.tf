module "data_mgmt_zone" {
  source = "github.com/hmcts/terraform-module-data-management-zone?ref=main"

  providers = {
    azurerm       = azurerm,
    azurerm.hub   = azurerm.hub
    azurerm.ssptl = azurerm.ssptl
  }

  env                           = var.env
  name                          = "ingest-mgmt"
  common_tags                   = module.ctags.common_tags
  default_route_next_hop_ip     = var.default_route_next_hop_ip
  address_space                 = var.mgmt_address_space
  hub_vnet_name                 = var.hub_vnet_name
  hub_resource_group_name       = var.hub_resource_group_name
  existing_purview_account      = var.existing_purview_account
  additional_kv_access_policies = var.mgmt_additional_kv_access_policies

  # Event Hub configuration
  eventhub_ns_sku               = var.eventhub_ns_sku
  services                      = var.services
  zone_redundant                = var.zone_redundant
  eventhub_capacity             = var.eventhub_capacity
  auto_inflate_enabled          = var.auto_inflate_enabled
  eventhub_auth_rules           = var.eventhub_auth_rules
  eventhub_namespace_auth_rules = var.eventhub_namespace_auth_rules
  eventhub_consumer_groups      = var.eventhub_consumer_groups
}
