resource "azurerm_subnet" "private_endpoint_subnet" {
  name                 = "ingest00-private-endpoints-${var.env}"
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.247.5.0/27"]
}