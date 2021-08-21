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
}

resource "time_sleep" "wait_90_seconds" {
  depends_on = [aws_instance.my-ec2-vm]
  create_duration = "90s"
}

  # Sync App1 Static Content to Webserver using Provisioners
resource "null_resource" "sync_app1_static" {
    depends_on = [ time_sleep.wait_90_seconds ]
    triggers = {
      always-update =  timestamp()
    }

  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type = "ssh"
    host = aws_instance.web.public_ip 
    user = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }  

  # Copies the app1 folder to /tmp
  provisioner "file" {
    source      = "apps"
    destination = "/tmp"
  }

  # Copies the /tmp/app1 folder to Apache Webserver /var/www/html directory
  provisioner "remote-exec" {
    inline = [
      "sudo cp -r /tmp/app/index.html /var/www/html"
    ]
  }
}