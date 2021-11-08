resource "aws_instance" "web" {
  ami               = "ami-083654bd07b5da81d"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1c"

  tags = {
    "Name" = "WebApp-terraform"
  }
  lifecycle {
    create_before_destroy = true
  }
}