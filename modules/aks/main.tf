resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = coalesce(var.dns_prefix, "${var.cluster_name}-dns")
  kubernetes_version  = var.kubernetes_version

  # Free tier SKU to eliminate control plane charges (ideal for learning/labs)
  sku_tier = "Free"

  default_node_pool {
    name            = "systempool"
    node_count      = var.node_count
    vm_size         = var.vm_size
    os_disk_size_gb = var.os_disk_size_gb
    os_disk_type    = "Managed"

    # Auto-scaling can be enabled if desired; using fixed node count for strict budgeting


    tags = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}
