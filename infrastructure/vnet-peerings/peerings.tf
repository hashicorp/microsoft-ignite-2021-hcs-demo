# peer AKS vnets
resource "azurerm_virtual_network_peering" "aks1_to_aks2" {
  name                      = "aks1_to_aks2"
  resource_group_name       = azurerm_resource_group.us_west_1.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "aks2_to_aks1" {
  name                      = "aks2_to_aks1"
  resource_group_name       = azurerm_resource_group.us_west_1.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}