terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Backend setup for Prod environment
  # backend "azurerm" {
  #   resource_group_name  = "rg-tfstate-prod"
  #   storage_account_name = "sttfstateprod123"
  #   container_name       = "tfstate"
  #   key                  = "prod.aks.tfstate"
  # }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
