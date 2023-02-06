# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = data.azurerm_resource_group.us_central.location
  resource_group_name = data.azurerm_resource_group.us_central.name
  address_space       = ["10.0.0.0/8"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet"
  resource_group_name  = data.azurerm_resource_group.us_central.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/16"]
}

# peer to HCS
data "azurerm_virtual_network" "hcsvnet1" {
  name                = hcs_cluster.dc1.vnet_name
  resource_group_name = hcs_cluster.dc1.managed_resource_group_name
}

resource "azurerm_virtual_network_peering" "aks1_to_hcs1" {
  name                      = "aks1_to_hcs1"
  resource_group_name       = data.azurerm_resource_group.us_central.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = data.azurerm_virtual_network.hcsvnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "hcs1_to_aks1" {
  name                      = "hcs1_to_aks1"
  resource_group_name       = hcs_cluster.dc1.managed_resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.hcsvnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
