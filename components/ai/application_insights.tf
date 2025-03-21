module "application_insights" {
  source = "git::https://github.com/hmcts/terraform-module-application-insights?ref=main"

  env      = var.env
  product  = var.product
  name     = "${var.product}-${var.component}-appinsights"
  location = var.location

  resource_group_name = azurerm_resource_group.rg.name

  common_tags = module.common_tags.common_tags
}