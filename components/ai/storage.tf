moved {
  from = module.storage.storage_account_id
  to   = module.ai.ai_storage_account_id
}

module "common_tags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.env
  product     = var.product
  builtFrom   = var.builtFrom
}