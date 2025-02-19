resource "azurerm_eventhub_namespace" "sbox-dlrm-eventhub-ns" {
  name                = var.eventhub_namespace_name # Reference the parameter for the name
  location            = "uksouth"
  resource_group_name = var.resource_group_name # Reference the resource group where this should be created
  sku                 = "Premium"

  tags = {
    application  = "dlrm-data-ingest"
    builtFrom    = "hmcts/dlrm-data-ingest-infra"
    businessArea = "cross-cutting"
    criticality  = "Low"
    environment  = "sandbox"
    expiresAfter = "3000-01-01"
    startupMode  = "always"
  }

  minimum_tls_version      = "1.2"
  maximum_throughput_units = 25
}


