resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu_ami.id //ami-0c2b8ca1dad447f8a
  instance_type               = var.inst_type
  availability_zone           = var.az_name
  count                       = terraform.workspace == "default" ? 3 : 1
  user_data                   = file("nginx-install.sh")
  key_name                    = "sudhams_virginia_demo"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_http_ssh.id]

  tags = {
    Name = "Nginx-application-${terraform.workspace}"
  }
}