/*
It's recommended to denote that the AWS Instance or Elastic IP depends on the Internet Gateway.
*/
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "DEMO-IGW"
  }
}