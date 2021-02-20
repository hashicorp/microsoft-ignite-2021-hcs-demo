output "rg" {
  value = data.azurerm_resource_group.us_central.name
}
output "url" {
  value = hcs_cluster.dc1.consul_external_endpoint_url
}
output "token" {
  value = hcs_cluster.dc1.consul_root_token_secret_id
}