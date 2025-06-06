import {
  to = module.ai.azurerm_storage_account.workspace_storage_account
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/dlrm-ingest-ai-sbox/providers/Microsoft.Storage/storageAccounts/dlrmingestaisasbox"
}

module "common_tags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.env
  product     = var.product
  builtFrom   = var.builtFrom
}