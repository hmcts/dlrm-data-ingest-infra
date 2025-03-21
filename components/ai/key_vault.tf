module "key_vault" {
  source = "git::https://github.com/hmcts/cnp-module-key-vault?ref=master"

  product                 = var.prodcut
  env                     = var.env
  object_id               = data.azurerm_client_config.current.object_id
  resource_group_name     = azurerm_resource_group.rg.name
  product_group_name      = "DTS Platform Operations"
  create_managed_identity = true
  common_tags             = module.common_tags.tags
}