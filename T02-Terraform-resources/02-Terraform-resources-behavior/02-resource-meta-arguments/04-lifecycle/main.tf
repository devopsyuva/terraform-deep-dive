resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1c"

  tags = {
    "Name" = "WebApp-terraform"
  }
  lifecycle {
    create_before_destroy = true
  }
}
/*
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1c"

  tags = {
    "Name" = "WebApp-terraform"
  }
  lifecycle {
    prevent_destroy = true
  }
}
*/
/*
Output for Above lifecycle Meta-argument:
root@terraformworkstation:~/terraform-aws/day6# terraform destroy
aws_instance.web: Refreshing state... [id=i-01666d56f858ecf31]
╷
│ Error: Instance cannot be destroyed
│
│   on instances.tf line 1:
│    1: resource "aws_instance" "web" {
│
│ Resource aws_instance.web has lifecycle.prevent_destroy set, but the plan calls for this resource to be destroyed. To avoid this error and continue with the plan, either
│ disable lifecycle.prevent_destroy or reduce the scope of the plan using the -target flag.
╵
root@terraformworkstation:~/terraform-aws/day6#
*/
/*
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1c"

  tags = {
    "Name" = "WebApp-terraform"
  }
  lifecycle {
    ignore_changes = [
      ami,
      tags,
    ]
  }
}
*/
/*
root@terraformworkstation:~/terraform-aws/day6# terraform plan
aws_instance.web: Refreshing state... [id=i-01666d56f858ecf31]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
*/