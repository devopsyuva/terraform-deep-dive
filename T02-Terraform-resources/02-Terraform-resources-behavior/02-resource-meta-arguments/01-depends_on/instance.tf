resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  key_name = "terraform-demo"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.test-security-group.id]
  user_data = file("nginx-install.sh")

  tags = {
    "Name" = "WebApp-terraform"
  }
}