resource "aws_instance" "web" {
  ami           = var.ami_name //ami-0c2b8ca1dad447f8a
  instance_type = var.inst_type
  count = var.inst_count
  availability_zone = var.az_name
  associate_public_ip_address = true
  key_name = "sudhams_virginia_demo"
  vpc_security_group_ids     = [aws_security_group.allow_http_ssh.id]

  tags = {
    Name = "nginx-terraform"
  }
}