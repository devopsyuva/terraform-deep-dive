resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "WebApp-terraform"
    #"Name" = "Nginx"
  }
}