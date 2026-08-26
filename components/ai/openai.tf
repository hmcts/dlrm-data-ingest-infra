resource "azurerm_cognitive_account" "openai" {
  count = var.deploy_openai ? 1 : 0

  name                  = "${var.product}-openai-${var.env}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  kind                  = "OpenAI"
  sku_name              = var.openai_account_sku
  custom_subdomain_name = "${var.product}-openai-${var.env}"

  tags = module.common_tags.common_tags
}