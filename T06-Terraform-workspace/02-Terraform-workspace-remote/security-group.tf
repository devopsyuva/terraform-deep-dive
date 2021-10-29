resource "aws_security_group" "allow_http_ssh" {
  name        = "allow-http-ssh-${terraform.workspace}"
  description = "Allow Ingress rules to allow SSH and HTTP connections"
  tags = {
    Name = "Nginx-application-${terraform.workspace}"
  }
}