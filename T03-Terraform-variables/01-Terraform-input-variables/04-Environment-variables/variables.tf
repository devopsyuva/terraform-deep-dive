variable "aws_region" {
    description = "Region on which resources will be created"
    type = string
    default = "us-east-1"
}
variable "az_name" {
    description = "Availability Zone name"
    type = string
    default = "us-east-1a"
}
variable "ami_name" {
    description = "Latest AMI ID on us-east-1"
    type = string
    default = "ami-0c2b8ca1dad447f8a"
}
variable "inst_type" {
    description = "Instance type used to launch EC2 Instance"
    type = string
    default = "t2.micro"
}
variable "inst_count" {
    description = "No of EC2 instances that need to launched"
    type = number
    default = 1
}