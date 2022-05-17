# Terraform AWS provider
terraform {
  required_version = ">= 1.0.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
    region = "us-east-1"
    profile = "default"
}