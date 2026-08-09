variable "aks_clusters" {
  type = map(object({
    rg_name            = string
    location           = string
    kubernetes_version = optional(string)
    node_count         = optional(number, 2)
    vm_size            = optional(string, "Standard_B2s")
    os_disk_size_gb    = optional(number, 30)
    tags               = optional(map(string), {})
  }))

  description = "Map of AKS cluster configurations for the Prod environment."
}
