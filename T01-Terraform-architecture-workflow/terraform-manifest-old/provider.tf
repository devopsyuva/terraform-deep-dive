#Single line comment, provider block
provider "aws" {
    version = "~> 3.0" // Terraform aws plugin version
    region = "us-east-1"
    profile = "default"
}

/*
Reference:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs
*/