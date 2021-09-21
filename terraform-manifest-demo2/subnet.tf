resource "aws_subnet" "demo-subnet-public" {
  count                   = length(local.public_subnets)
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = element(values(local.public_subnets), count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(keys(local.public_subnets), count.index)

  tags = var.tag_name
}

resource "aws_subnet" "demo-subnet-private" {
  count                   = length(local.private_subnets)
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = element(values(local.private_subnets), count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(keys(local.private_subnets), count.index)

  tags = var.tag_name
}