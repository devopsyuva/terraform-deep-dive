# Terraform resource targeting
- **-target** option can be used to focus Terraform's attention on only a subset of resources.
- This targeting capability is provided for exceptional circumstances, such as recovering form mistakes or working around Terraform limitations.
- It is not recommended to use -target for routine operations, since this can lead to undectected configuration drift and confusion about how the true state of resources relates to configuration.
- Instead of using -target as a means to operate on isolated of very large configurations, prefer instead to break large configurations into several smaller configurations that can each be independently applied.

```
# Lets add new tag of the instance resource.
# Add new EC2 Resource

# List resources from state
- terraform state list

#Lets check with plan with target
- terraform plan -target=aws_instance.web --> new instance will not be show to get effected because of terget specified to old instance
# Above command shows resource and dependent resource will be "Update in-place" effected

# Based on review, the above resource and dependent resource need to be applied using below command
- terraform apply -target=aws_instance.web [-auto-approve]
│ Warning: Applied changes may be incomplete
│
│ The plan was created with the -target option in effect, so some changes requested in the configuration may have been ignored and the output
│ values may not be fully updated. Run the following command to verify that no other changes are pending:
│     terraform plan
│
│ Note that the -target option is not suitable for routine use, and is provided only for exceptional situations such as recovering from
│ errors or mistakes, or when Terraform specifically suggests to use it as part of an error message.
╵
```

- Below example shows, by default to create three resource. But if we need to create a specific resource out of them. Then we need to use "-taget=<resource_name>" which we can check in #terraform plan.
- If resource is already create and now you want to apply -target, then we can see the resource that you want to control #terraform state list
```
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# terraform plan -target=aws_instance.demo[2]
Acquiring state lock. This may take a few moments...

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.demo[2] will be created
  + resource "aws_instance" "demo" {
...
...
Plan: 1 to add, 0 to change, 0 to destroy.
╷
│ Warning: Resource targeting is in effect
│
│ You are creating a plan with the -target option, which means that the result of this plan may not represent all of the changes requested by the current
│ configuration.
│
│ The -target option is not for routine use, and is provided only for exceptional situations such as recovering from errors or mistakes, or when Terraform
│ specifically suggests to use it as part of an error message.
╵

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
Releasing state lock. This may take a few moments...
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery#
```