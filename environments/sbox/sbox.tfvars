default_route_next_hop_ip = "10.10.200.36"
hub_vnet_name             = "hmcts-hub-sbox-int"
hub_resource_group_name   = "hmcts-hub-sbox-int"
hub_subscription_id       = "ea3a8c1e-af9d-4108-bc86-a7e2d267f49c"
mgmt_address_space        = ["10.147.2.0/24"]

landing_zones = {
  00 = {
    address_space                                    = ["10.147.5.0/24", "10.147.6.0/24"]
    services_subnet_address_space                    = ["10.147.5.0/27"]
    services_mysql_subnet_address_space              = ["10.147.5.32/27"]
    data_bricks_public_subnet_address_space          = ["10.147.5.64/27"]
    data_bricks_private_subnet_address_space         = ["10.147.5.96/27"]
    data_bricks_product_public_subnet_address_space  = ["10.147.5.128/27"]
    data_bricks_product_private_subnet_address_space = ["10.147.6.0/27"]
    data_integration_001_subnet_address_space        = ["10.147.6.32/27"]
    data_integration_002_subnet_address_space        = ["10.147.6.64/27"]
    data_product_001_subnet_address_space            = ["10.147.6.96/27"]
    data_product_002_subnet_address_space            = ["10.147.6.128/27"]
  }
}

existing_purview_account = {
  resource_id = "/subscriptions/a8140a9e-f1b0-481f-a4de-09e2ee23f7ab/resourceGroups/mi-sbox-rg/providers/Microsoft.Purview/accounts/mi-purview-sbox"
  identity = {
    principal_id = "b92d5586-c076-4598-bccf-4ba081889621"
    tenant_id    = "531ff96d-0ae9-462a-8d2d-bec7c0b42082"
  }
}
