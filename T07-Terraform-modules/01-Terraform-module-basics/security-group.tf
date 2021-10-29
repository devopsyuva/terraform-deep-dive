resource "aws_security_group" "allow_http_ssh" {
  name        = "allow-http-ssh"
  description = "Allow Ingress rules to allow SSH and HTTP connections"
}