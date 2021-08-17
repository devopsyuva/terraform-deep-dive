/*
This configuration will create 5 EC2 instances
on AWS provider
*/
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  key_name = "terraform-demo"
  user_data = file("nginx-install.sh")
  count = 5
  #availability_zone = "us-east-1a"

  tags = {
    "Name" = "WebApp-terraform"
    "Name" = "Nginx-${count.index}"
  }
}