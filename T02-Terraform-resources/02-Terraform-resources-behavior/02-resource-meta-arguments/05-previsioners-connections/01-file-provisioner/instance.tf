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
/*
Error:
╷
│ Error: file provisioner error
│
│   with aws_instance.web[0],
│   on instance.tf line 16, in resource "aws_instance" "web":
│   16:   provisioner "file" {
│
│ timeout - last error: SSH authentication failed (ubuntu@100.24.8.102:22): ssh: handshake failed: ssh: unable to authenticate,
│ attempted methods [none publickey], no supported methods remain
╵
Reference:
https://www.terraform.io/language/resources/provisioners/connection#argument-reference
*/
/*
source: The source file or directory
content: A direct content to copy on the destination. This argument cannot be combined with source
destination: (Required) The destination path to write to on the remote system
- [Provisioner Arguments](https://www.terraform.io/language/resources/provisioners/file#argument-reference)
- [Reference](https://github.com/heldersepu/hs-scripts/blob/master/TerraForm/ec2_ubuntu.tf#L21)
*/