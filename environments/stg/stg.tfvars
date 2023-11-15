default_route_next_hop_ip = "10.11.72.36"
hub_vnet_name             = "hmcts-hub-nonprodi"
hub_resource_group_name   = "hmcts-hub-nonprodi"
hub_subscription_id       = "fb084706-583f-4c9a-bdab-949aac66ba5c"
mgmt_address_space        = ["10.247.1.0/24"]

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
