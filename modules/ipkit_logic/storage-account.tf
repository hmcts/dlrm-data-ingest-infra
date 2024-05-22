module "storage" {
  source                            = "github.com/hmcts/cnp-module-storage-account?ref=feat%2Finfra-encryption"
  env                               = var.env
  storage_account_name              = "ingest${var.landing_zone_key}logic${var.env}"
  resource_group_name               = var.resource_group_name
  location                          = "uksouth"
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  enable_hns                        = false
  enable_sftp                       = false
  enable_nfs                        = false
  enable_data_protection            = false
  enable_versioning                 = false
  pim_roles                         = {}
  infrastructure_encryption_enabled = false
  default_action                    = "Allow"

  sa_subnets = [
    data.azurerm_subnet.ssptl-00.id,
    data.azurerm_subnet.ssptl-01.id
  ]

  team_contact = "#dtspo-orange"
  common_tags  = var.common_tags
}

resource "azurerm_private_endpoint" "this" {
  name                = "ingest${var.landing_zone_key}logic${var.env}-pe"
  resource_group_name = var.resource_group_name
  location            = "uksouth"
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.common_tags

  private_service_connection {
    name                           = module.storage.storageaccount_name
    is_manual_connection           = false
    private_connection_resource_id = module.storage.storageaccount_id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "endpoint-dnszonegroup"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.blob.id]
  }
}
