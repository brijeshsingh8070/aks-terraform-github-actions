variable "resource_groups" {
  description = "Resource groups configuration"

  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}