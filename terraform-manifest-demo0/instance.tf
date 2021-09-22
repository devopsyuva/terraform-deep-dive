resource "aws_instance" "web" {
  ami                         = "${data.aws_ami.ubuntu_image.id}" //ami-0c2b8ca1dad447f8a
  instance_type               = var.inst_type
  availability_zone           = var.az_name
  associate_public_ip_address = true
  key_name                    = "sudhams_virginia_demo"
  vpc_security_group_ids     = [aws_security_group.allow_http_ssh.id]
  user_data                   = <<EOF
#!/bin/bash
sudo apt update && apt -y dist-upgrade
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1>Welcome to Terraform Intrastructure Automation on AWS</h1>" > /var/www/html/index.html
echo "<h1>Welcome to Terraform Intrastructure Automation on AWS</h1>" > /usr/share/nginx/html/index.html
EOF

  tags = {
    Name = "WebApp-terraform"
  }
}