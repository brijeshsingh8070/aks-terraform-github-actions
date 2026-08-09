resource "azurerm_kubernetes_cluster" "this" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix         = var.dns_prefix
  kubernetes_version = var.kubernetes_version

  sku_tier = "Free"

  default_node_pool {

    name       = "system"
    vm_size    = "Standard_B2s"
    node_count = 1

    vnet_subnet_id = var.subnet_id

    type = "VirtualMachineScaleSets"

    os_disk_type    = "Ephemeral"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {

    admin_username = "azureuser"

    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  network_profile {

    network_plugin = "azure"

    network_plugin_mode = "overlay"

    load_balancer_sku = "standard"

    outbound_type = "loadBalancer"

    service_cidr   = "10.10.0.0/16"
    dns_service_ip = "10.10.0.10"
    pod_cidr       = "10.244.0.0/16"
  }

  tags = var.tags
}
module "node_pool" {

  source = "./node-pool"

  for_each = var.node_pools

  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id

  name            = each.value.name
  vm_size         = each.value.vm_size
  node_count      = each.value.node_count
  min_count       = each.value.min_count
  max_count       = each.value.max_count
  mode            = each.value.mode
  os_disk_size_gb = each.value.os_disk_size_gb

  tags = var.tags
}