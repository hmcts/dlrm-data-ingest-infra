module "ai_services" {
  source                       = "git::https://github.com/hmcts/terraform-module-ai-services?ref=main"
  env                          = var.env
  project                      = var.project
  existing_resource_group_name = azurerm_resource_group.rg.name
  common_tags                  = module.common_tags.common_tags
  product                      = var.product
  component                    = var.component
  storage_account_id           = module.storage.storageaccount_id
  key_vault_id                 = module.key_vault.key_vault_id
  application_insights_id      = module.application_insights.id
}