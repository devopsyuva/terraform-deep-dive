# AWS EC2 Instance Module
module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "my-modules-demo"
  instance_count = 2

  ami                    = data.aws_ami.ubuntu_ami.id
  instance_type          = var.inst_type
  key_name               = "awsdemokey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  subnet_id              = "subnet-a3c120ef" # Get one public subnet id from default vpc and replace
  user_data              = file("nginx-install.sh")

  tags = local.environment-name
}