terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }

  # Backend setup for Preprod environment
  # backend "azurerm" {
  #   resource_group_name  = "rg-tfstate-preprod"
  #   storage_account_name = "sttfstatepreprod123"
  #   container_name       = "tfstate"
  #   key                  = "preprod.aks.tfstate"
  # }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
