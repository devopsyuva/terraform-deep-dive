resource "aws_instance" "web" {
  ami           = data.aws_ami.amzlinux //ami-0c2b8ca1dad447f8a
  instance_type = var.inst_type
  count = var.inst_count
  key_name = "terraform-aws"
  availability_zone = var.az_name
  user_data = file(nginx-install.sh)
  vpc_security_group_ids = [aws_security_group.vpc-ssh-web.id]

  tags = {
    Name = "WebApp-terraform"
  }
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }
  privisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> ec2-private-ipaddress.txt"
    working_dir = "local-exec-output-files/"
  }

  provisioner "local-exec" {
    when = destroy
    command = "echo Destroy-time provisioner EC2 instance at `date` >> ec2-destroy.txt"
    working_dir = "local-exec-output-files/"
  }
}
/*
- [local-exec](https://www.terraform.io/language/resources/provisioners/local-exec#argument-reference)
*/