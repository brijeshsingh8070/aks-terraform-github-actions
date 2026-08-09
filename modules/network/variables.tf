variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnets" {
  description = "Subnet configuration"

  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "tags" {
  type = map(string)
}
variable "api_server_authorized_ip_ranges" {
  description = "Authorized IP ranges for AKS API server"
  type        = list(string)
}