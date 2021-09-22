# Terraform Input Variables type with list and map
- List(or tuple):
  - List are sequence of values stored/reffered to a single key/variable.
  - Elements in list or tuple are identified by consecutive whole number, starting with zero.
```
variable "inst_type" {
    description = "value"
    type = list(string)
    default = [ "t3.micro", "t3.small", "t3.medium" ]
}

#terraform plan --> check if right value is picked "t3.small" while calling in resource block as var.inst_type[1]
```

- Map(or object):
  - A group of values identified by named labels.
```
variable "ec2_instance_tags" {
   description = "Default tags to be used"
   type =  map(string)
   default = {
       "Name" = "webapp"
       "Environment" = "Dev"
       "Type" = "Application"
   }
}

#terraform plan --> check if tags are updated with the list specified in variables.
var.ec2_instance_tags or to call specific value of a key var.ec2_instance_tags["Type"]
```

## References
- [Input list type](https://www.terraform.io/docs/language/values/variables.html)
- [Expressions Types and Values](https://www.terraform.io/docs/language/expressions/types.html)