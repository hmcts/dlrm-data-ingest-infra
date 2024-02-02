default_route_next_hop_ip = "10.11.8.36"
hub_vnet_name             = "hmcts-hub-prod-int"
hub_resource_group_name   = "hmcts-hub-prod-int"
hub_subscription_id       = "0978315c-75fe-4ada-9d11-1eb5e0e0b214"
mgmt_address_space        = ["10.247.0.0/24"]

mgmt_additional_kv_access_policies = {
  "cf408942-3215-4a3a-bdf2-e703c688bc13" = {
    secret_permissions = ["Get", "List"]
  }
}

landing_zones = {}
