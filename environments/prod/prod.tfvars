default_route_next_hop_ip = "10.11.8.36"
hub_vnet_name             = "hmcts-hub-prod-int"
hub_resource_group_name   = "hmcts-hub-prod-int"
hub_subscription_id       = "0978315c-75fe-4ada-9d11-1eb5e0e0b214"
mgmt_address_space        = ["10.247.0.0/24"]

landing_zones = {}

existing_purview_account = {
  resource_id = "/subscriptions/a8140a9e-f1b0-481f-a4de-09e2ee23f7ab/resourceGroups/mi-sbox-rg/providers/Microsoft.Purview/accounts/mi-purview-sbox"
  identity = {
    principal_id = "b92d5586-c076-4598-bccf-4ba081889621"
    tenant_id    = "531ff96d-0ae9-462a-8d2d-bec7c0b42082"
  }
}
