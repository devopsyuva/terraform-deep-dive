resource "aws_subnet" "demo-subnet-public" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.244.1.0/24"

  tags = {
    Name = "DEMO-SUBNET-PUBLIC"
  }
}

resource "aws_subnet" "demo-subnet-private" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.244.2.0/24"

  tags = {
    Name = "DEMO-SUBNET-PRIVATE"
  }
}

resource "aws_subnet" "in_secondary_cidr" {
  vpc_id     = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block = "172.10.0.0/24"
}