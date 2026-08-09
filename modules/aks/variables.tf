variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "node_pools" {
  description = "AKS node pools"

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