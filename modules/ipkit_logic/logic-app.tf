resource "azurerm_logic_app_standard" "this" {
  name                       = "ingest${var.landing_zone_key}-logic-${var.env}"
  resource_group_name        = var.resource_group_name
  location                   = "uksouth"
  app_service_plan_id        = azurerm_service_plan.this.id
  storage_account_name       = module.storage.storageaccount_name
  storage_account_access_key = module.storage.storageaccount_primary_access_key

  virtual_network_subnet_id = var.logicapp_subnet_id

  identity {
    type = "SystemAssigned"
  }
}