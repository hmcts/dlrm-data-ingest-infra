default_route_next_hop_ip = "10.10.200.36"
hub_vnet_name             = "hmcts-hub-sbox-int"
hub_resource_group_name   = "hmcts-hub-sbox-int"
hub_subscription_id       = "ea3a8c1e-af9d-4108-bc86-a7e2d267f49c"
mgmt_address_space        = ["10.247.2.0/24"]

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
  "01" = {
    project = "another example landing zone"
    role_based_access_control = [
      {
        name = "DTS Platform Operations"
        type = "Group"
      }
    ]
  }
}
