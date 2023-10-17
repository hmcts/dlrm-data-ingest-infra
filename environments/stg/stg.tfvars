default_route_next_hop_ip = "10.11.72.36"
hub_vnet_name             = "hmcts-hub-nonprodi"
hub_resource_group_name   = "hmcts-hub-nonprodi"
hub_subscription_id       = "fb084706-583f-4c9a-bdab-949aac66ba5c"
mgmt_address_space        = ["10.247.1.0/24"]

landing_zones = {
  "00" = {
    address_space                                    = ["10.247.10.0/24", "10.247.11.0/24"]
    services_subnet_address_space                    = ["10.247.10.0/27"]
    services_mysql_subnet_address_space              = ["10.247.10.32/27"]
    data_bricks_public_subnet_address_space          = ["10.247.10.64/27"]
    data_bricks_private_subnet_address_space         = ["10.247.10.96/27"]
    data_bricks_product_public_subnet_address_space  = ["10.247.10.128/27"]
    data_bricks_product_private_subnet_address_space = ["10.247.11.0/27"]
    data_integration_001_subnet_address_space        = ["10.247.11.32/27"]
    data_integration_002_subnet_address_space        = ["10.247.11.64/27"]
    data_product_001_subnet_address_space            = ["10.247.11.96/27"]
    data_product_002_subnet_address_space            = ["10.247.11.128/27"]
  }
}
