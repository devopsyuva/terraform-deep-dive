variable "inst_type" {
    description = "Multiple instance types"
    type = list(string)
    default = [ "t3.micro", "t3.small", "t3.medium" ]
}
variable "inst_count" {
    description = "No of EC2 instances to be launched"
    type = number
    default = 1
}
variable "ec2_instance_tags" {
   description = "Default tags to be used"
   type =  map(string)
   default = {
       "Name" = "webapp"
       "Environment" = "Dev"
       "Type" = "Application"
   }
}