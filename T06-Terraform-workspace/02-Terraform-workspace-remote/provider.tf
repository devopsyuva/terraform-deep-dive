terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "terraform-demo-sudheer"
    key    = "workspaces/terraform.tfstate"
    region = "us-east-1"

    #For state locking
    dynamodb_table = "terraform-dev-state-table"
  }
}
provider "aws" {
  region  = var.aws_region
  profile = "default"
}