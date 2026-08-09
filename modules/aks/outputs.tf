output "cluster_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "The Kubernetes Managed Cluster ID."
}

output "cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The Kubernetes Managed Cluster Name."
}

output "oidc_issuer_url" {
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  description = "The OIDC issuer URL for workload identity integration."
}

output "kube_config_raw" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
  description = "Raw Kubernetes config file for connecting to the cluster."
}

output "get_credentials_command" {
  value       = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${azurerm_kubernetes_cluster.aks.name}"
  description = "Azure CLI command to fetch cluster credentials and configure kubectl."
}
