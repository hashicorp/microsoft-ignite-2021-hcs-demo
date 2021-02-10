output "rg" {
  value = azurerm_resource_group.us_west_1.name
}
output "url" {
  value = hcs_cluster.dc1.consul_external_endpoint_url
}
output "token" {
  value = hcs_cluster.dc1.consul_root_token_secret_id
}