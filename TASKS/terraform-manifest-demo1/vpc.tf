resource "aws_vpc" "demo-vpc" {
  cidr_block           = "10.244.0.0/16"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"

  tags = {
    Name = "DEMO-VPC"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "172.10.0.0/16"
}