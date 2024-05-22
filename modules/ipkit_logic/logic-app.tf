resource "azurerm_logic_app_standard" "this" {
  name                       = "ingest${var.landing_zone_key}-logic-${var.env}"
  resource_group_name        = var.resource_group_name
  location                   = "uksouth"
  app_service_plan_id        = azurerm_service_plan.this.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  version                    = "~4"
  tags                       = var.common_tags

  virtual_network_subnet_id = var.logicapp_subnet_id

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = module.application_insights.instrumentation_key
    "APPINSIGHTS_CONNECTION_STRING"  = module.application_insights.connection_string
  }
}

resource "azapi_resource" "sql_conn" {
  type      = "Microsoft.Web/connections@2016-06-01"
  name      = "ingest${var.landing_zone_key}-sqlConn-${var.env}"
  parent_id = "/subscriptions/${data.azurerm_client_config.this.subscription_id}/resourceGroups/${var.resource_group_name}"
  location  = "uksouth"
  body = {
    properties = {
      displayName = "ingest${var.landing_zone_key}-sql-${var.env}"
      api = {
        name        = "sql",
        displayName = "SQL Server",
        description = "Microsoft SQL Server is a relational database management system developed by Microsoft. Connect to SQL Server to manage data. You can perform various actions such as create, update, get, and delete on rows in a table.",
        iconUri     = "https://connectoricons-prod.azureedge.net/releases/v1.0.1686/1.0.1686.3706/sql/icon.png",
        brandColor  = "#ba141a",
        id          = "/subscriptions/${data.azurerm_client_config.this.subscription_id}/providers/Microsoft.Web/locations/uksouth/managedApis/sql",
        type        = "Microsoft.Web/locations/managedApis"
      }
    }
  }
}
