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
    "FUNCTIONS_WORKER_RUNTIME" = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~14"
    "sql_databaseName" = "MetadataControl"
    "sql_serverName" = "ingest${var.landing_zone_key}-metadata-mssql-${var.env}"
    "WEBSITE_CONTENTOVERVNET" = "1"
    "WEBSITE_RUN_FROM_PACKAGE" = "0"
    "ServiceProviders.Sql.QueryTimeout" = "00:02:00"
  }
}

resource "azurerm_resource_group_template_deployment" "sqlConn" {
  name                = "logicapp-sql-conn-deployment"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "identityId" = {
      value = azurerm_logic_app_standard.this.identity[0].principal_id
    }
  })
  template_content = file("${path.module}/templates/sql-connection.json")
}
