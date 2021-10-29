locals {
  environment-name = var.tag_name
}
variable "aws_region" {
  description = "Region on which resources will be created"
  type        = string
  default     = "us-east-1"
}
variable "inst_type" {
  description = "Instance type used to launch EC2 Instance"
  type        = string
  default     = "t2.micro"
}
variable "tag_name" {
  description = "Default tag will be added to all resource when used"
  type        = map(string)
  default     = {
    Name = "terraform-webapp-demo"
    Env  = "Prod"
  }
}