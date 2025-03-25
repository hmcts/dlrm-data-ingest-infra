module "key_vault" {
  source = "git::https://github.com/hmcts/cnp-module-key-vault?ref=master"

  name                    = "${var.product}-${var.component}-kv-${var.env}"
  product                 = var.product
  env                     = var.env
  object_id               = data.azurerm_client_config.current.object_id
  resource_group_name     = azurerm_resource_group.rg.name
  product_group_name      = "DTS Platform Operations"
  create_managed_identity = true
  common_tags             = module.common_tags.common_tags
}

resource "azurerm_key_vault_secret" "cognitive_account_primary_access_key" {
  name         = "cognitive-account-primary-access-key"
  value        = module.ai.cognitive_account_primary_access_key
  key_vault_id = module.key_vault.key_vault_id
}

resource "azurerm_key_vault_secret" "cognitive_account_secondary_access_key" {
  name         = "cognitive-account-secondary-access-key"
  value        = module.ai.cognitive_account_secondary_access_key
  key_vault_id = module.key_vault.key_vault_id
}