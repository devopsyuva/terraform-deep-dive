resource "aws_vpc" "my_vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "test-vpc"
  }
}