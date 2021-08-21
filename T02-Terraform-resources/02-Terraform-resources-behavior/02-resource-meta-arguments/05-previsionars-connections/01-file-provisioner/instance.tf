resource "aws_instance" "web" {
  ami           = data.aws_ami.amzlinux //ami-0c2b8ca1dad447f8a
  instance_type = var.inst_type
  count = var.inst_count
  key_name = "terraform-aws"
  availability_zone = var.az_name
  user_data = file(nginx-install.sh)
  vpc_security_group_ids = [aws_security_group.vpc-ssh-web.id]

  tags = {
    Name = "WebApp-${terraform.workspace}"
  }
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }
  /*
  Add on_failure = continue to skip taint for the failed resource of provisioner
  */
  provisioner "file" {
    source = "apps/index.html"
    destination = "/tmp/index.html"
  }
  /*
  provisioner "file" {
    source = "apps/index.html"
    destination = "/usr/share/nginx/html/index.html"
    #on_failure = continue
  }
  */
}