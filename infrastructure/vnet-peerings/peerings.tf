provider "azurerm" {
  version = "~>2.0"
  features {}
}

data "azurerm_resource_group" "us_central" {
  name = "hcs-ignite-us-central"
}

data "azurerm_resource_group" "us_west_2" {
  name = "hcs-ignite-us-west-2"
}

data "azurerm_virtual_network" "vnet1" {
  name = "vnet1"
  resource_group_name       = data.azurerm_resource_group.us_central.name
}

data "azurerm_virtual_network" "vnet2" {
  name = "vnet2"
  resource_group_name       = data.azurerm_resource_group.us_west_2.name
}

provider "hcs" { }

# peer AKS vnets
resource "azurerm_virtual_network_peering" "aks1_to_aks2" {
  name                      = "aks1_to_aks2"
  resource_group_name       = data.azurerm_resource_group.us_central.name
  virtual_network_name      = data.azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "aks2_to_aks1" {
  name                      = "aks2_to_aks1"
  resource_group_name       = data.azurerm_resource_group.us_west_2.name
  virtual_network_name      = data.azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}