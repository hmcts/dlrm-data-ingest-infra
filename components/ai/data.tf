data "azurerm_client_config" "current" {
}

data "azurerm_virtual_network" "vnet" {
  name                = "ingest00-vnet-{$var.env}"
  resource_group_name = "ingest00-network-${var.env}"
}