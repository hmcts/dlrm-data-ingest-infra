module "data_landing_zone" {
  source = "github.com/hmcts/terraform-module-data-landing-zone?ref=main"

  providers = {
    azurerm        = azurerm
    azurerm.ssptl  = azurerm.ssptl
    azurerm.cftptl = azurerm.cftptl
    azurerm.soc    = azurerm.soc
    azurerm.cnp    = azurerm.cnp
  }

  env                                              = var.env
  name                                             = "dlrm-ingest-landing"
  common_tags                                      = module.ctags.common_tags
  default_route_next_hop_ip                        = var.default_route_next_hop_ip
  vnet_address_space                               = var.landing_address_space
  services_subnet_address_space                    = var.services_subnet_address_space
  services_mysql_subnet_address_space              = var.services_mysql_subnet_address_space
  data_bricks_public_subnet_address_space          = var.data_bricks_public_subnet_address_space
  data_bricks_private_subnet_address_space         = var.data_bricks_private_subnet_address_space
  data_bricks_product_public_subnet_address_space  = var.data_bricks_product_public_subnet_address_space
  data_bricks_product_private_subnet_address_space = var.data_bricks_product_private_subnet_address_space
  data_integration_001_subnet_address_space        = var.data_integration_001_subnet_address_space
  data_integration_002_subnet_address_space        = var.data_integration_002_subnet_address_space
  data_product_001_subnet_address_space            = var.data_product_001_subnet_address_space
  data_product_002_subnet_address_space            = var.data_product_002_subnet_address_space
}
