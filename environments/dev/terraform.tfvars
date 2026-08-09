location = "Central India"

resource_groups = {
  aks = {
    name     = "rg-aks-dev"
    location = "Central India"

    tags = {
      Environment = "dev"
      Project     = "aks-practice"
      ManagedBy   = "Terraform"
    }
  }
}


vnet_name = "vnet-aks-dev"

vnet_address_space = [
  "10.20.0.0/16"
]


subnets = {
  aks = {
    name = "snet-aks"

    address_prefixes = [
      "10.20.1.0/24"
    ]
  }
}


aks_name   = "aks-dev-practice"
dns_prefix = "aks-dev-practice"



kubernetes_version = "1.32"

node_pools = {

  application = {
    name            = "apps"
    vm_size         = "Standard_B2s"
    node_count      = 1
    min_count       = 1
    max_count       = 1
    mode            = "User"
    os_disk_size_gb = 30
  }

}

ssh_public_key = "REPLACE_WITH_YOUR_SSH_PUBLIC_KEY"


tags = {
  Environment = "dev"
  Project     = "aks-practice"
  Owner       = "Brijesh"
  ManagedBy   = "Terraform"
}
api_server_authorized_ip_ranges = [
  "122.161.53.150/32"
]