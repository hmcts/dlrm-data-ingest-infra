moved {
  from = module.storage.azurerm_storage_account.storage_account
  to   = module.ai.azurerm_storage_account.workspace_storage_account
}

module "common_tags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.env
  product     = var.product
  builtFrom   = var.builtFrom
}