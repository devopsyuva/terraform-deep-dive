# Terraform settings block
terraform {
  required_providers { # Nested Block
    azurerm = {
      source  = "hashicorp/azurerm" # registry.terraform.io --> URL
      version = "3.113.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "virtualmachinedemo"
    storage_account_name = "visualpathdemoaccount"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }
}

# Provider block
provider "azurerm" {
  # Configuration options
  features {}
}