resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = var.inst_type[1] // or var.inst_type[0], var.inst_type[2]
  count = var.inst_count
  availability_zone = "us-east-1c"
  key_name = "sudhams_virginia_demo"
  associate_public_ip_address = true

  tags = var.ec2_instance_tags
}