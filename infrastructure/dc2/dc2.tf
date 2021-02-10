provider "azurerm" {
  version = "~>2.0"
  features {}
}

provider "hcs" { }

// Create a federation token
data "hcs_federation_token" "dc1" {
  resource_group_name      = hcs_cluster.dc1.resource_group_name
  managed_application_name = hcs_cluster.dc1.managed_application_name
}

// Create dc2
resource "hcs_cluster" "dc2" {
  resource_group_name      = azurerm_resource_group.rg.name
  managed_application_name = "dc2"
  email                    = "dstrickland@hashicorp.com"
  cluster_mode             = "production"
  min_consul_version       = "v1.9.1"
  vnet_cidr                = "172.25.17.0/24"
  consul_datacenter        = "dc2"
  consul_federation_token  = data.hcs_federation_token.dc1.token
  consul_external_endpoint = true
}

