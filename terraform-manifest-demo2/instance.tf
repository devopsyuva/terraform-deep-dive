resource "aws_instance" "web" {
  count                       = length(local.public_subnets)
  ami                         = var.ami_name //ami-0c2b8ca1dad447f8a
  instance_type               = var.inst_type
  key_name                    = "sudhams_virginia_demo"
  user_data                   = file("nginx-install.sh")
  vpc_security_group_ids      = [aws_security_group.allow_tls_ssh.id]
  subnet_id                   = element(aws_subnet.demo-subnet-public.*.id, count.index)
  associate_public_ip_address = true

  tags = var.tag_name

}