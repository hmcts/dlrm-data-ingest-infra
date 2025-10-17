locals {
  is_sbox                   = length(regexall(".*(s?box).*", var.env)) > 0
  ssptl_vnet_name           = "ss-ptl-vnet"
  ssptl_vnet_resource_group = "ss-ptl-network-rg"
}

data "azurerm_subnet" "ssptl-00" {
  provider             = azurerm.ssptl
  name                 = "aks-00"
  virtual_network_name = local.ssptl_vnet_name
  resource_group_name  = local.ssptl_vnet_resource_group
}

data "azurerm_subnet" "ssptl-01" {
  provider             = azurerm.ssptl
  name                 = "aks-01"
  virtual_network_name = local.ssptl_vnet_name
  resource_group_name  = local.ssptl_vnet_resource_group
}

data "azurerm_private_dns_zone" "blob" {
  provider            = azurerm.cftptl
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "core-infra-intsvc-rg"
}

data "azurerm_client_config" "this" {}
