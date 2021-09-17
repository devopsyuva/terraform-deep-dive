# Terraform taint/untaint
- These commands helps us to force recreate the resources.
- **terraform taint** command manually marks a terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
- **terraform untaint**
  - The terraform untaint command manually unmarks a terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
  - This reverses either a manual terraform taint or the result of provisioners failing on a resource.
  - This command will not modify infrastructure, but does modify the state file in order to unmark a resource as tainted.
```
# List terraform managed resources from state file
- terraform state list

# Taint a specific resource from the above list
- terraform taint aws_instance.web --> it marked the resource as taint

# Now lets check the changes with #terraform plan and see what it does to the tainted resource it shows taint resource should be "-/+ destroy and the create replacement" and "resource is tainted, so must be replaced" statement

# Optional: lets untaint the same resource which we did and observe changes with #terraform plan

# Based on review use #terraform apply [-auto-approve]
```