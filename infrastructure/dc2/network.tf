# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  location            = data.azurerm_resource_group.us_west_2.location
  resource_group_name = data.azurerm_resource_group.us_west_2.name
  address_space       = ["11.0.0.0/8"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet"
  resource_group_name  = data.azurerm_resource_group.us_west_2.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["11.0.0.0/16"]
}

data "azurerm_virtual_network" "hcsvnet2" {
  name                = hcs_cluster.dc2.vnet_name
  resource_group_name = hcs_cluster.dc2.managed_resource_group_name
}

resource "azurerm_virtual_network_peering" "aks2_to_hcs2" {
  name                      = "aks2_to_hcs2"
  resource_group_name       = data.azurerm_resource_group.us_west_2.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = data.azurerm_virtual_network.hcsvnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "hcs2_to_aks2" {
  name                      = "hcs2_to_aks2"
  resource_group_name       = hcs_cluster.dc2.managed_resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.hcsvnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}