module "resource_group" {
  source = "../../modules/resource-group"

  resource_groups = var.resource_groups
}


module "network" {
  source = "../../modules/network"

  resource_group_name = module.resource_group.resource_group_names["aks"]
  location            = var.location

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  subnets = var.subnets

  tags = var.tags
}
module "aks" {

  source = "../../modules/aks"

  name                = var.aks_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_names["aks"]

  subnet_id = module.network.subnet_ids["aks"]

  dns_prefix         = var.dns_prefix
  kubernetes_version = var.kubernetes_version
  ssh_public_key     = var.ssh_public_key

  node_pools = var.node_pools

  tags = var.tags
}

