/*
Multi-line comment to explain
Terraforn settings block details
*/
terraform {
  required_version = "= 1.0.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws" //This is also a single line comment
      version = "~> 3.0"
    }
  }
}
#Single line comment
provider "aws" {
  region = var.aws_region
  profile = "default"
}