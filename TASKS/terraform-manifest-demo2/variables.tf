variable "tag_name" {
  description = "Common Tag for all services handled from this root module"
  type        = map(string)
  default = {
    Name = "Demo-Application"
    Env  = "WebApplication"
  }
}
variable "aws_region" {
  description = "Region on which resources will be created"
  type        = string
  default     = "us-east-1"
}
variable "az_name" {
  description = "Availability Zone name"
  type        = string
  default     = "us-east-1a"
}
variable "vpc_cidr" {
  description = "VPC CIDR for demo application"
  type        = string
  default     = "10.244.0.0/16"
}
locals {
  public_subnets = {
    "${var.aws_region}a" = "10.244.1.0/24"
    "${var.aws_region}b" = "10.244.2.0/24"
    "${var.aws_region}c" = "10.244.3.0/24"
  }
  private_subnets = {
    "${var.aws_region}a" = "10.244.4.0/24"
    "${var.aws_region}b" = "10.244.5.0/24"
    "${var.aws_region}c" = "10.244.6.0/24"
  }
}
variable "ami_name" {
  description = "Latest AMI ID on us-east-1"
  type        = string
  default     = "ami-09e67e426f25ce0d7" #Ubuntu 20.04 LTS Free tier
}
variable "inst_type" {
  description = "Instance type used to launch EC2 Instance"
  type        = string
  default     = "t2.small"
}
variable "inst_count" {
  description = "No of EC2 instances that need to launched"
  type        = number
  default     = 1
}