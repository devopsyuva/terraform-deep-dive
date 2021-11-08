/*
This configuration will create 5 EC2 instances
on AWS provider
*/
resource "aws_instance" "web" {
  ami           = "ami-09e67e426f25ce0d7" #Ubuntu 20.04 LTS Free Tier Image
  instance_type = "t2.micro"
  key_name      = "terraform-demo"
  user_data     = file("nginx-install.sh")
  count         = 5
  #availability_zone = "us-east-1a"

  tags = {
    "Name" = "Nginx-${count.index}"
  }
}