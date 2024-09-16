# Terraform settings block
terraform {
  required_providers { # Nested Block
    azurerm = {
      source  = "hashicorp/azurerm" # registry.terraform.io --> URL
      version = "3.113.0"
    }
  }
}

# Provider block
provider "azurerm" {
  # Configuration options
  features {}
}