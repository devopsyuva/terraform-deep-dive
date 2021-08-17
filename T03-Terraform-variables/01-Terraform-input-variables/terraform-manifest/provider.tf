terraform {
  required_version = "= 1.0.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.1, < 3.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
}