default_route_next_hop_ip = "10.10.200.36"
hub_vnet_name             = "hmcts-hub-sbox-int"
hub_resource_group_name   = "hmcts-hub-sbox-int"
hub_subscription_id       = "ea3a8c1e-af9d-4108-bc86-a7e2d267f49c"
mgmt_address_space        = ["10.247.2.0/24"]

mgmt_additional_kv_access_policies = {
  "71523201-c046-4371-bdd0-a1e1abcd05c5" = {
    secret_permissions = ["Get", "List"]
  }
}

landing_zones = {
  "00" = {
    project = "example landing zone"
    role_based_access_control = [
      {
        name = "prasanna.krishnan@justice.gov.uk"
        type = "User"
      },
      {
        name = "dominic.leary@justice.gov.uk"
        type = "User"
      },
      {
        name = "isha.shrivastava1@justice.gov.uk"
        type = "User"
      }
    ]
  }
}
