/*
Terraform Settings Block
Provider Block
*/
# Terraform AWS provider
terraform {
  required_version = ">= 1.0.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.1, < 3.2"
    }
  }
}

/*
required_version = "~> 3.0.3"
required_version = "= 3.0.3"
required_version = ">= 3.0.3"
required_version = "<= 3.0.3"
required_version = "!= 3.0.3"
*/
provider "aws" {
  region = "us-east-1"
}