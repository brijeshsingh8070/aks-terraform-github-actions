module "resource_group" {
  source   = "../../modules/resource_group"
  for_each = var.aks_clusters

  name     = each.value.rg_name
  location = each.value.location
  tags     = each.value.tags
}

module "aks" {
  source   = "../../modules/aks"
  for_each = var.aks_clusters

  cluster_name        = each.key
  resource_group_name = module.resource_group[each.key].name
  location            = each.value.location
  kubernetes_version  = each.value.kubernetes_version
  node_count          = each.value.node_count
  vm_size             = each.value.vm_size
  os_disk_size_gb     = each.value.os_disk_size_gb
  tags                = each.value.tags

  depends_on = [module.resource_group]
}
