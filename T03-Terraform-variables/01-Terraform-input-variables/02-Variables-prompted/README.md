# Terraform Input Variables When Prompted
- We will not define any default value in variables.tf file.
- Value will be passed when we execute commands like #terraform plan/apply.
- We need to pass the value as per requirement.
```
root@terraformworkstationdemo:~/terraform-aws/variables# terraform plan
var.az_name
  Availability Zone name should be region defined in aws_region variable

  Enter a value: us-east-1b

var.inst_type
  Instance type used to launch EC2 Instance

  Enter a value: t3.micro
```