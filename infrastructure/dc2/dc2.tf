# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  version = "~>2.0"
  features {}
}

data "azurerm_resource_group" "us_west_2" {
  name = "hcs-ignite-us-west-2"
}

data "azurerm_resource_group" "us_central" {
  name = "hcs-ignite-us-central"
}

data "hcs_cluster" "dc1" {
  resource_group_name = data.azurerm_resource_group.us_central.name
  managed_application_name = "dc1"
}

provider "hcs" { }

// Create a federation token
data "hcs_federation_token" "dc1" {
  resource_group_name      = data.hcs_cluster.dc1.resource_group_name
  managed_application_name = data.hcs_cluster.dc1.managed_application_name
}

// Create dc2
resource "hcs_cluster" "dc2" {
  resource_group_name      = data.azurerm_resource_group.us_west_2.name
  managed_application_name = "dc2"
  email                    = "education@hashicorp.com"
  cluster_mode             = "production"
  min_consul_version       = "v1.9.1"
  vnet_cidr                = "172.25.17.0/24"
  consul_datacenter        = "dc2"
  consul_federation_token  = data.hcs_cluster.dc1.consul_federation_token
  consul_external_endpoint = true
}

