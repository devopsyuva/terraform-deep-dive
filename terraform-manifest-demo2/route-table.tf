resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "public-route"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "private-route"
  }
}

resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demo-igw.id
  depends_on             = [aws_internet_gateway.demo-igw]
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(local.public_subnets)
  subnet_id      = element(aws_subnet.demo-subnet-public.*.id, count.index)
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(local.private_subnets)
  subnet_id      = element(aws_subnet.demo-subnet-private.*.id, count.index)
  route_table_id = aws_route_table.private-route-table.id
}