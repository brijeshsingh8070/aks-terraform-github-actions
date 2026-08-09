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

variable "node_pools" {

  description = "Additional AKS user node pools"

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
variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
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