variable "location" {
  type = string
}

variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "aks_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "node_pools" {

  type = map(object({
    name            = string
    vm_size         = string
    node_count      = number
    min_count       = number
    max_count       = number
    mode            = string
    os_disk_size_gb = number
  }))
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

variable "tags" {
  type = map(string)
}
variable "api_server_authorized_ip_ranges" {
  description = "Public IP ranges allowed to access AKS API server"
  type        = list(string)
}
