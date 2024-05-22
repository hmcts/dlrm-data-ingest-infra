resource "azurerm_storage_account" "this" {
  name                      = "ingest${var.landing_zone_key}logic${var.env}"
  resource_group_name       = var.resource_group_name
  location                  = "uksouth"
  account_tier              = var.storage_account_tier
  account_kind              = var.storage_account_kind
  account_replication_type  = var.storage_replication_type
  enable_https_traffic_only = true
  tags                      = var.common_tags
}

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id = azurerm_storage_account.this.id
  depends_on         = [azurerm_logic_app_standard.this]

  default_action             = "Deny"
  ip_rules                   = []
  virtual_network_subnet_ids = [data.azurerm_subnet.ssptl-00.id, data.azurerm_subnet.ssptl-01.id, var.logicapp_subnet_id]
  bypass                     = ["AzureServices"]
}

resource "azurerm_private_endpoint" "this" {
  name                = "ingest${var.landing_zone_key}logic${var.env}-pe"
  resource_group_name = var.resource_group_name
  location            = "uksouth"
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.common_tags

  private_service_connection {
    name                           = azurerm_storage_account.this.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "endpoint-dnszonegroup"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.blob.id]
  }
}
