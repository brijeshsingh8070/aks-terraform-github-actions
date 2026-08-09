variable "cluster_name" {
  type        = string
  description = "The name of the AKS cluster."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the cluster."
}

variable "location" {
  type        = string
  description = "The Azure region where the AKS cluster will be created."
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix specified when creating the managed cluster."
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the cluster."
  default     = null
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the system node pool (default 2 for lab practice)."
  default     = 2
}

variable "vm_size" {
  type        = string
  description = "VM SKU for the node pool (e.g. Standard_B2s for lowest cost)."
  default     = "Standard_B2s"
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB (30GB for cost optimization)."
  default     = 30
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the AKS cluster resources."
  default     = {}
}
