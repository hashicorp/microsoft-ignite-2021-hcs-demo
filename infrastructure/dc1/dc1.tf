provider "azurerm" {
  version = "~>2.0"
  features {}
}

data "azurerm_resource_group" "us_central" {
  name = "hcs-ignite-us-central"
}

provider "hcs" { }

// Create dc1
resource "hcs_cluster" "dc1" {
  resource_group_name      = data.azurerm_resource_group.us_central.name
  managed_application_name = "dc1"
  email                    = "education@hashicorp.com"
  cluster_mode             = "production"
  min_consul_version       = "v1.9.1"
  vnet_cidr                = "172.25.16.0/24"
  consul_datacenter        = "dc1"
  consul_external_endpoint = true
}