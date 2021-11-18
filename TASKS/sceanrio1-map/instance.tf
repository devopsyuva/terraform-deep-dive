resource "aws_instance" "web" {
  ami                         = var.ami_name //ami-0c2b8ca1dad447f8a
  for_each                    = var.inst_type
  instance_type               = each.value
  availability_zone           = var.az_name
  key_name                    = "sudhams_virginia_demo"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_http_ssh.id]

  tags = {
    Name = "WebApp-terraform-${each.key}"
  }
}