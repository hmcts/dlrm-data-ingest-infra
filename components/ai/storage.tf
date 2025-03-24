module "storage" {
  source                     = "git::https://github.com/hmcts/cnp-module-storage-account?ref=4.x"
  env                        = var.env
  storage_account_name       = "${replace(var.product, "-", "")}${var.component}"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = var.location
  account_kind               = "StorageV2"
  account_replication_type   = "ZRS"
  common_tags                = module.common_tags.common_tags
  private_endpoint_subnet_id = data.azurerm_subnet.private_endpoint_subnet.id
}

module "common_tags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.env
  product     = var.product
  builtFrom   = var.builtFrom
}