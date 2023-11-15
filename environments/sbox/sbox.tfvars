default_route_next_hop_ip = "10.10.200.36"
hub_vnet_name             = "hmcts-hub-sbox-int"
hub_resource_group_name   = "hmcts-hub-sbox-int"
hub_subscription_id       = "ea3a8c1e-af9d-4108-bc86-a7e2d267f49c"
mgmt_address_space        = ["10.247.2.0/24"]

landing_zones = {
  "00" = {
    address_space                                    = ["10.247.3.0/24", "10.247.4.0/24"]
    services_subnet_address_space                    = ["10.247.3.0/27"]
    services_mysql_subnet_address_space              = ["10.247.3.32/27"]
    data_bricks_public_subnet_address_space          = ["10.247.3.64/27"]
    data_bricks_private_subnet_address_space         = ["10.247.3.96/27"]
    data_bricks_product_public_subnet_address_space  = ["10.247.3.128/27"]
    data_bricks_product_private_subnet_address_space = ["10.247.4.0/27"]
    data_integration_001_subnet_address_space        = ["10.247.4.32/27"]
    data_integration_002_subnet_address_space        = ["10.247.4.64/27"]
    data_product_001_subnet_address_space            = ["10.247.4.96/27"]
    data_product_002_subnet_address_space            = ["10.247.4.128/27"]
    role_based_access_control = [
      {
        name = "Alex.Bance@justice.gov.uk"
        type = "User"
      },
      {
        name = "Alex.Bance"
        type = "User"
      },
      {
        name = "DTS Platform Operations"
        type = "Group"
      }
    ]
  }
}
