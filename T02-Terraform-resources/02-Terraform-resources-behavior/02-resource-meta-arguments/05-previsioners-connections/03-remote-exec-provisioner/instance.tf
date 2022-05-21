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
  provisioner "file" {
    source = "apps/index.html"
    destination = "/tmp/index.html"
  }
  provisioner "remote-exec" {
    inline = [
      "sleep 120", # will sleep for 120 seconds to ensure apache package installed and running
      "sudo cp /tmp/index.html /var/www/html /usr/share/nginx/html"
    ]
  }
}
/*
- [Provisioner connection](https://www.terraform.io/language/resources/provisioners/connection)
*/