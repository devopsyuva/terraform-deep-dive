# Terraform resource targeting
- -target option can be used to focus Terraform's attention on only a subset of resources.
- This targeting capability is provided for exceptional circumstances, such as recovering form mistakes or working around Terraform limitations.
- It is not recommended to use -target for routine operations, since this can lead to undectected configuration drift and confusion about how the true state of resources relates to configuration.
- Instead of using -target as a means to operate on isolated of very large configurations, prefer instead to break large configurations into several smaller configurations that can each be independently applied.

```
#Lets add new tag of the instance resource.
#Add some additional inbound rule for new port to open from outside.
#Add new EC2 Resource

#List resources from state
terraform state list

#Lets check with plan with target
terraform plan -target=aws_instance.web --> new instance will not be show to get effected because of terget specified to old instance
```