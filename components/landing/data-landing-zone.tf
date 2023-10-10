module "data_landing_zone" {
  source = "github.com/hmcts/terraform-module-data-landing-zone?ref=main"

  for_each = var.landing_zones

  providers = {
    azurerm        = azurerm
    azurerm.ssptl  = azurerm.ssptl
    azurerm.cftptl = azurerm.cftptl
    azurerm.soc    = azurerm.soc
    azurerm.cnp    = azurerm.cnp
  }

  env                                              = var.env
  name                                             = "ingest${each.key}"
  existing_purview_account                         = var.existing_purview_account
  common_tags                                      = module.ctags.common_tags
  default_route_next_hop_ip                        = var.default_route_next_hop_ip
  vnet_address_space                               = each.value.address_space
  services_subnet_address_space                    = each.value.services_subnet_address_space
  services_mysql_subnet_address_space              = each.value.services_mysql_subnet_address_space
  data_bricks_public_subnet_address_space          = each.value.data_bricks_public_subnet_address_space
  data_bricks_private_subnet_address_space         = each.value.data_bricks_private_subnet_address_space
  data_bricks_product_public_subnet_address_space  = each.value.data_bricks_product_public_subnet_address_space
  data_bricks_product_private_subnet_address_space = each.value.data_bricks_product_private_subnet_address_space
  data_integration_001_subnet_address_space        = each.value.data_integration_001_subnet_address_space
  data_integration_002_subnet_address_space        = each.value.data_integration_002_subnet_address_space
  data_product_001_subnet_address_space            = each.value.data_product_001_subnet_address_space
  data_product_002_subnet_address_space            = each.value.data_product_002_subnet_address_space
}
