provider "azurerm" {
  version = "~>2.0"
  features {}
}

provider "hcs" { }

resource "azurerm_resource_group" "rg" {
  name     = "hcs-ignite-dc1"
  location = "westus2"
}

// Create dc1
resource "hcs_cluster" "dc1" {
  resource_group_name      = azurerm_resource_group.us_west_1.name
  managed_application_name = "dc1"
  email                    = "education@hashicorp.com"
  cluster_mode             = "production"
  min_consul_version       = "v1.9.1"
  vnet_cidr                = "172.25.16.0/24"
  consul_datacenter        = "dc1"
  consul_external_endpoint = true
}