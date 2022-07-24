resource "aws_vpc" "demo-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"

  tags = {
    Name = "DEMO-VPC"
  }
}