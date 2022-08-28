resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu_ami.id //ami-0c2b8ca1dad447f8a
  instance_type          = var.inst_type
  count                  = var.inst_count
  availability_zone      = var.az_name
  user_data              = file("nginx-install.sh")
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]

  tags = {
    Name = local.environment-name
  }
}