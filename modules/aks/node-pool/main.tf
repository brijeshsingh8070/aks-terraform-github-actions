resource "azurerm_kubernetes_cluster_node_pool" "this" {

  name                  = var.name
  kubernetes_cluster_id = var.kubernetes_cluster_id

  vm_size    = var.vm_size
  node_count = var.node_count

  auto_scaling_enabled = true

  min_count = var.min_count
  max_count = var.max_count

  mode = var.mode

  os_disk_type    = "Ephemeral"
  os_disk_size_gb = var.os_disk_size_gb

  tags = var.tags
}