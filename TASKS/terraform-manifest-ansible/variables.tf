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
variable "inst_type" {
    description = "Instance type used to launch EC2 Instance"
    type = string
    default = "t2.micro"
}
variable "repo_name" {
    description = "Repo name to create in AWS CodeCommit"
    type = string
    default = "devproject"
}