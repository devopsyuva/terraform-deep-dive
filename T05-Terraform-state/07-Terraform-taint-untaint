# Terraform taint/untaint
- Terraform taint command manually marks a terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
- Terraform untaint
  - The terraform untaint command manually unmarks a terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
  - This reverses either a manual terraform taint or the result of provisioners failing on a resource.
  - This command will not modify infrastructure, but does modify the state file in order to unmark a resource as tainted.
```
#terraform state list

#terraform taint aws_instance.web --> it marked the resource as taint

#Now lets check the changes with #terraform plan and see what it does to the tainted resource
it shows taint resource should be "-/+ destroy and the create replacement" statement

#Optional: lets untaint the same resource which we did and observe changes with #terraform plan

#Based on review use #terraform apply [-auto-approve]
```