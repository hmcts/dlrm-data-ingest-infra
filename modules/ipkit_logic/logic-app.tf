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
  name      = "LogicAppSqlConn"
  parent_id = "/subscriptions/${data.azurerm_client_config.this.subscription_id}/resourceGroups/${var.resource_group_name}"
  location  = "uksouth"

  body = {
    properties = {
      displayName = "sql"
      parameterValues = {
        oauthMI = {}
      }
      api = {
        id = "/subscriptions/${data.azurerm_client_config.this.subscription_id}/providers/Microsoft.Web/locations/uksouth/managedApis/sql",
      }
    }
  }
}

resource "azapi_resource" "sql_conn_access" {
  type      = "Microsoft.Web/connections/accessPolicies@2018-07-01-preview"
  name      = "LogicAppSqlConnAccessPolicies"
  parent_id = azapi_resource.sql_conn.id
  location  = "uksouth"
  body = {
    principal = {
      type = "ActiveDirectory"
      identity = {
        objectId = azurerm_logic_app_standard.this.identity[0].principal_id
        tenantId = data.azurerm_client_config.this.tenant_id
      }
    }
  }
}
