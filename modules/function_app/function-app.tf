resource "azurerm_service_plan" "this" {
  name                = "ingest${var.landing_zone_key}-func-asp-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
  tags                = var.common_tags
}

resource "azurerm_linux_function_app" "this" {
  name                       = "ingest${var.landing_zone_key}-func-${var.env}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  virtual_network_subnet_id  = var.function_app_subnet_id
  https_only                 = true
  tags                       = var.common_tags

  identity {
    type = "SystemAssigned"
  }

  site_config {
    vnet_route_all_enabled = true
    application_stack {
      python_version = var.python_version
    }
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = module.application_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = module.application_insights.connection_string
  }

  # App settings are configured post-provisioning by the application team.
  lifecycle {
    ignore_changes = [app_settings]
  }
}
