terraform {
  required_version = ">= 1.0.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # S3 bucket for storing state file in remote backend
  backend "s3" {
    bucket = "terraform-statefiles-sudheer"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"
}
/*
terraform {
  required_version = ">= 1.0.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # S3 bucket for storing state file in remote backend
  backend "s3" {
    bucket = "terraform-statefiles-sudheer"
    key = "Prod/terraform.tfstate"
    region = "us-east-1"

    # State Locking using DynamoDB Table
    dynamodb_table = "terraform-dev-state-table"
  }
}

provider "aws" {
    region = var.aws_region
    profile = "default"
}
*/