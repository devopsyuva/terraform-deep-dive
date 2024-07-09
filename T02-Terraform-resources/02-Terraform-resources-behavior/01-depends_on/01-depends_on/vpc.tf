resource "aws_vpc" "my_vpc" {
  cidr_block          = "10.10.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = "terraform-vpc"
  }
}
