resource "aws_instance" "web" {
  ami                         = "${data.aws_ami.ubuntu_image.id}"
  instance_type               = var.inst_type
  availability_zone           = var.az_name
  associate_public_ip_address = true
  key_name                    = "awsdemokey"
  vpc_security_group_ids     = [aws_security_group.allow_http_ssh.id]
  user_data                   = <<EOF
#!/bin/bash
sudo apt update && apt -y dist-upgrade
sudo apt install -y software-properties-common unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
aws s3 cp s3://private_key/ssh_key ~/.ssh/know_hosts
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
sudo useradd -u 1005 -m -d /home/ansibleuser -s /bin/bash -c "ansible user was created for testing" --password $(perl -e "print crypt('test12345', '\$6\$salt\$')") ansibleuser
sudo usermod -aG sudo ansibleuser
EOF

  tags = {
    Name = "WebApp-terraform"
  }
}