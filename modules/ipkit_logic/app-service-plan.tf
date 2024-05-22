resource "azurerm_service_plan" "this" {
  name                = "ingest${var.landing_zone_key}-app-service-plan-${var.env}"
  resource_group_name = var.resource_group_name
  location            = "uksouth"
  os_type             = var.os_type
  sku_name            = var.asp_sku_name
}
