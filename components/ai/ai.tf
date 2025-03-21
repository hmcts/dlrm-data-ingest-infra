module "ai_services" {
  source                       = "github.com/hmcts/terraform-module-ai-services"
  env                          = var.env
  project                      = var.project
  existing_resource_group_name = azurerm_resource_group.rg.name
  common_tags                  = var.common_tags
  product                      = var.product
  component                    = var.component
  storage_account_id           = module.storage.storage_account_id
  key_vault_id                 = module.key_vault.key_vault_id
  application_insights_id      = module.application_insights.application_insights_id
}