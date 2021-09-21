resource "aws_security_group" "allow_tls_ssh" {
  name        = "allow_tls_ssh"
  description = "Allow TLS and SSH inbound traffic"
  vpc_id      = aws_vpc.demo-vpc.id

  tags = {
    Name = "DEMO-SG"
  }
}