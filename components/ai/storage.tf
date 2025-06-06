import {
  to = module.ai.azurerm_storage_account.workspace_storage_account
  id = data.azurerm_storage_account.workspace_storage_account.id
}

module "common_tags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.env
  product     = var.product
  builtFrom   = var.builtFrom
}