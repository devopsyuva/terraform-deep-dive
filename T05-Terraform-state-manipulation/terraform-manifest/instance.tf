resource "aws_instance" "web" {
  ami               = var.ami_name //ami-0c2b8ca1dad447f8a
  instance_type     = var.inst_type
  count             = var.inst_count
  availability_zone = var.az_name

  tags = {
    Name = "WebApp-terraform"
  }
}