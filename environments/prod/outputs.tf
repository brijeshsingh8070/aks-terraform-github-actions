output "cluster_details" {
  value = {
    for cluster_key, cluster_module in module.aks : cluster_key => {
      cluster_id              = cluster_module.cluster_id
      cluster_name            = cluster_module.cluster_name
      resource_group          = var.aks_clusters[cluster_key].rg_name
      get_credentials_command = cluster_module.get_credentials_command
    }
  }
  description = "Summary details for all prod AKS clusters."
}

output "get_credentials_commands" {
  value = [
    for cluster_key, cluster_module in module.aks : cluster_module.get_credentials_command
  ]
  description = "Azure CLI commands to configure kubectl for prod clusters."
}
