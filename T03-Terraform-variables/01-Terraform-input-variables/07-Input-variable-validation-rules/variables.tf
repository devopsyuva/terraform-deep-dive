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
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}