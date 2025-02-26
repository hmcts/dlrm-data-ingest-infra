resource "azurerm_eventhub_namespace" "sbox-dlrm-eventhub-ns" {
  name                = var.eventhub_namespace_name
  location            = "uksouth"
  resource_group_name = var.resource_group_name
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

  minimum_tls_version           = "1.2"
  maximum_throughput_units      = 25
  auto_inflate_enabled          = var.auto_inflate_enabled
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled  = var.local_authentication_enabled

}


