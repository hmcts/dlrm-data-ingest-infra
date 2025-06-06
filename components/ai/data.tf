data "azurerm_client_config" "current" {
}

data "azurerm_virtual_network" "vnet" {
  name                = "ingest00-vnet-${var.env}"
  resource_group_name = "ingest00-network-${var.env}"
}

data "azurerm_subnet" "private_endpoint_subnet" {
  name                 = "ingest00-services-${var.env}"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_subnet" "azure_devops_agent_subnet" {
  provider             = azurerm.ssptl
  name                 = "aks-00"
  virtual_network_name = local.is_sbox ? "ss-ptlsbox-vnet" : "ss-ptl-vnet"
  resource_group_name  = local.is_sbox ? "ss-ptlsbox-network-rg" : "ss-ptl-network-rg"
}

data "azuread_group" "poc_group" {
  display_name     = "DTS DLRM ARIA Migration"
  security_enabled = true
}

data "azurerm_storage_account" "ingest_storage_account" {
  name                = "ingest00sftp${var.env}"
  resource_group_name = "ingest00-main-${var.env}"
}

data "azurerm_storage_account" "workspace_storage_account" {
  name                = "dlrmingestai${var.env}"
  resource_group_name = "dlrm-ingest-ai-${var.env}"
}