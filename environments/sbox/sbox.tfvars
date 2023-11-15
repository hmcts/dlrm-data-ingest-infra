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
        name = "Alex.Bance@justice.gov.uk"
        type = "User"
      },
      {
        name = "Alex.Bance@HMCTS.NET"
        type = "User"
      },
      {
        name = "DTS Platform Operations"
        type = "Group"
      }
    ]
  }
}
