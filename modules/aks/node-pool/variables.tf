variable "kubernetes_cluster_id" {
  type = string
}

variable "name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "node_count" {
  type = number
}

variable "min_count" {
  type = number
}

variable "max_count" {
  type = number
}

variable "mode" {
  type = string
}

variable "os_disk_size_gb" {
  type = number
}

variable "tags" {
  type = map(string)
}