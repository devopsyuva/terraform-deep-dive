variable "aws_region" {
  description = "Region on which resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "az_name" {
  description = "Availability Zone name should be region defined in aws_region variable"
  type        = string
  default     = "us-east-1a"
}

variable "ami_name" {
  description = "Latest AMI ID on us-east-1"
  type        = string
  default     = "ami-0c2b8ca1dad447f8a"
}

variable "environment" {
  description = "Pass env name as per var.inst_type"
  type        = string
}

variable "inst_type" {
  description = "Instance type used to launch EC2 Instance"
  type        = map(string)
  default = {
    "dev"     = "t2.micro"
    "staging" = "t2.small"
    "prod"    = "t2.large"
  }
}