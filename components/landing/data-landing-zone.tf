data "azurerm_subscription" "current" {}

module "data_landing_zone" {
  source = "github.com/hmcts/terraform-module-data-landing-zone?ref=main"

  for_each = var.landing_zones

  providers = {
    azurerm        = azurerm
    azurerm.hub    = azurerm.hub
    azurerm.f5     = azurerm.f5
    azurerm.ssptl  = azurerm.ssptl
    azurerm.cftptl = azurerm.cftptl
    azurerm.soc    = azurerm.soc
    azurerm.cnp    = azurerm.cnp
    azurerm.dcr    = azurerm.dcr
  }

  env                                              = var.env
  name                                             = "ingest${each.key}"
  existing_purview_account                         = var.existing_purview_account
  common_tags                                      = merge(module.ctags.common_tags, local.auto_shutdown_common_tags, { "Data-Ingest-Project" = each.value.project })
  default_route_next_hop_ip                        = var.default_route_next_hop_ip
  vnet_address_space                               = concat([cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1)], each.value.additional_vnet_address_space)
  services_subnet_address_space                    = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 2, 0)]
  data_bricks_public_subnet_address_space          = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 2)]
  data_bricks_private_subnet_address_space         = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 3)]
  data_bricks_product_public_subnet_address_space  = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 4)]
  data_bricks_product_private_subnet_address_space = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 5)]
  data_integration_001_subnet_address_space        = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 3, 0)]
  data_integration_002_subnet_address_space        = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 3, 1)]
  data_product_001_subnet_address_space            = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 2, 1)]
  data_product_002_subnet_address_space            = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 2, 2)]
  services_mysql_subnet_address_space              = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 4, 12)]
  bastion_host_subnet_address_space                = each.value.deploy_bastion ? [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 2, 3)] : null
  additional_subnets                               = local.additional_subnets[each.key]
  hub_vnet_name                                    = var.hub_vnet_name
  hub_resource_group_name                          = var.hub_resource_group_name
  legacy_databases                                 = each.value.legacy_databases
  use_microsoft_ip_kit_structure                   = each.value.use_microsoft_ip_kit_structure
  adf_deploy_purview_private_endpoints             = each.value.adf_deploy_purview_private_endpoints
  additional_nsg_rules                             = each.value.additional_nsg_rules
  key_vault_readers                                = ["145da22b-a3cb-4ba8-b735-22c94b5eea6c"]
  deploy_sftp_storage                              = each.value.deploy_sftp_storage
  arm_object_id                                    = var.arm_object_id

  install_azure_monitor   = var.install_azure_monitor
  systemassigned_identity = var.systemassigned_identity
}

# For peerings with hub
resource "azurerm_role_assignment" "reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Reader"
  principal_id         = var.network_contributor_principal_id
}
resource "azurerm_role_assignment" "network_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Network Contributor"
  principal_id         = var.network_contributor_principal_id
}