resource "aws_instance" "web" {
  ami           = var.ami_name //ami-0c2b8ca1dad447f8a
  instance_type = var.inst_type
  availability_zone = var.az_name
  user_data = file("nginx-install.sh")
  vpc_security_group_ids = [aws_security_group.vpc-ssh-web.id]

  tags = {
    Name = "WebApp-terraform"
  }
}