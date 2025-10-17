# import hub-to-ingest00-vnet-sbox peering
import {
  to = module.data_landing_zone["00"].module.vnet_peer_hub.azurerm_virtual_network_peering.target_to_initiator
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest00-network-sbox/providers/Microsoft.Network/virtualNetworks/ingest00-vnet-sbox/virtualNetworkPeerings/ingest00-vnet-sbox-to-hub"
}

# import hub-to-ingest01-vnet-sbox peering
import {
  to = module.data_landing_zone["01"].module.vnet_peer_hub.azurerm_virtual_network_peering.target_to_initiator
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest01-network-sbox/providers/Microsoft.Network/virtualNetworks/ingest01-vnet-sbox/virtualNetworkPeerings/ingest01-vnet-sbox-to-hub"
}

# import hub-to-ingest05-vnet-sbox peering
import {
  to = module.data_landing_zone["05"].module.vnet_peer_hub.azurerm_virtual_network_peering.target_to_initiator
  id = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest05-network-sbox/providers/Microsoft.Network/virtualNetworks/ingest05-vnet-sbox/virtualNetworkPeerings/ingest05-vnet-sbox-to-hub"
}
