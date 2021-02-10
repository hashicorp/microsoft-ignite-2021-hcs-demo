output "rg" {
  value = azurerm_resource_group.us_west_2.name
}

output "url" {
  value = hcs_cluster.dc2.consul_external_endpoint_url
}