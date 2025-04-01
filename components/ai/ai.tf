module "ai" {
  source                       = "git::https://github.com/hmcts/terraform-module-ai-services?ref=DTSPO-24907/private-endpoint"
  env                          = var.env
  project                      = var.project
  existing_resource_group_name = azurerm_resource_group.rg.name
  common_tags                  = module.common_tags.common_tags
  product                      = var.product
  component                    = var.component
  storage_account_id           = module.storage.storageaccount_id
  key_vault_id                 = module.key_vault.key_vault_id
  application_insights_id      = module.application_insights.id
  cognitive_account_kind       = "FormRecognizer"
  cognitive_account_sku        = var.cognitive_account_sku
  subnet_id                    = data.azurerm_subnet.private_endpoint_subnet.id
  min_node_count               = var.min_node_count
  ip_rules                     = var.cognitive_account_ip_rules
}
