resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  user_data = file("nginx-install.sh")
  key_name = "sudhams_virginia_demo"
  associate_public_ip_address = true
  vpc_security_group_ids     = [aws_security_group.allow_http_ssh.id]

  tags = {
    "Name" = "WebApp-terraform"
  }
}