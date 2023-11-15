default_route_next_hop_ip = "10.11.8.36"
hub_vnet_name             = "hmcts-hub-prod-int"
hub_resource_group_name   = "hmcts-hub-prod-int"
hub_subscription_id       = "0978315c-75fe-4ada-9d11-1eb5e0e0b214"
mgmt_address_space        = ["10.247.0.0/24"]

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
