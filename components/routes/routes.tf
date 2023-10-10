resource "azurerm_route" "mgmt" {
  for_each               = toset(var.mgmt_address_space)
  name                   = "dlrm-ingest-mgmt-${replace(each.key, "/", "-")}-${var.env}"
  resource_group_name    = data.azurerm_route_table.ssptl.resource_group_name
  route_table_name       = data.azurerm_route_table.ssptl.name
  address_prefix         = each.value
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.default_route_next_hop_ip
}

resource "azurerm_route" "landing" {
  for_each               = toset(local.landing_zone_prefixes)
  name                   = "dlrm-ingest-landing-${replace(each.key, "/", "-")}-${var.env}"
  resource_group_name    = data.azurerm_route_table.ssptl.resource_group_name
  route_table_name       = data.azurerm_route_table.ssptl.name
  address_prefix         = each.value
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.default_route_next_hop_ip
}
