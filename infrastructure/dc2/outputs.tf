output "rg" {
  value = azurerm_resource_group.rg.name
}

output "url" {
  value = hcs_cluster.dc2.consul_external_endpoint_url
}