resource "azurerm_template_deployment" "sbox-dlrm-eventhub-ns" {
  name                = "sbox-dlrm-eventhub-ns"
  resource_group_name = "ingest-mgmt-rg-sbox"
  template_content    = file("modules/ipkit_logic/templates/eventhub_ns_template.json")

  parameters = {
    eventhubNamespaceName = var.eventhub_namespace_name
  }

  parameters_body = file("modules/ipkit_logic/templates/parameters.json")

  deployment_mode = "Incremental"
}
