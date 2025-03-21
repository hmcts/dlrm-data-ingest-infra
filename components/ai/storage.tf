module "storage" {
  source                   = "git::https://github.com/hmcts/cnp-module-storage-account?ref=4.x"
  env                      = var.env
  storage_account_name     = "${var.product}${var.component}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_kind             = "Standard"
  account_replication_type = "ZRS"
}