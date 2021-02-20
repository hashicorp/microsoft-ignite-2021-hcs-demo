# AKS cluster setup
resource "azurerm_kubernetes_cluster" "dc1" {
  identity {
    type = "SystemAssigned"
  }
  name                = "dc1"
  location            = data.azurerm_resource_group.us_central.location
  resource_group_name = data.azurerm_resource_group.us_central.name
  dns_prefix          = "dc1-dns"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = 3
    vm_size         = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.subnet1.id
  }

  network_profile {
    network_plugin = "kubenet"
    dns_service_ip = "10.233.0.10"
    service_cidr = "10.233.0.0/16"
    pod_cidr = "10.244.0.0/16"
    docker_bridge_cidr = "172.171.0.1/16"
  }
}
