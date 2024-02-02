default_route_next_hop_ip = "10.11.72.36"
hub_vnet_name             = "hmcts-hub-nonprodi"
hub_resource_group_name   = "hmcts-hub-nonprodi"
hub_subscription_id       = "fb084706-583f-4c9a-bdab-949aac66ba5c"
mgmt_address_space        = ["10.247.1.0/24"]

mgmt_additional_kv_access_policies = {
  "085f0992-85b4-49ae-aae8-ef47953e96f2" = {
    secret_permissions = ["Get", "List"]
  }
}

landing_zones = {}
