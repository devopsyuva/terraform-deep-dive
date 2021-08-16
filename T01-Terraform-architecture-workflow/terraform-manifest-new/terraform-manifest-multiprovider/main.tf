resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"

  tags = {
    Name = "WebApp-terraform"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  provider      = aws.west

  tags = {
    Name = "WebApp-terraform"
  }
}