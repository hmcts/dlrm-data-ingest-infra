resource "azurerm_resource_group" "rg" {
  name     = "dlrm-aria-${var.env}"
  location = var.location

  tags = module.common_tags.tags
}