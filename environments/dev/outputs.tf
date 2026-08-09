output "resource_group_names" {
  value = module.resource_group.resource_group_names
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "aks_name" {
  value = module.aks.name
}

output "aks_fqdn" {
  value = module.aks.fqdn
}

output "aks_node_resource_group" {
  value = module.aks.node_resource_group
}

output "aks_node_pools" {
  value = module.aks.node_pools
}