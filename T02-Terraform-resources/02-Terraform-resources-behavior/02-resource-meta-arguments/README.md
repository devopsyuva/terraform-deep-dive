# Terraform Resource Meta-arguments
- These meta-arguments are used to change the behavior of resources with any resource type.
- Types of meta-arguments:
  - **depends_on:** Use the depends_on meta-argument to handle hidden resource or module dependencies that Terraform can't automatically infer. Since terraform can't identify the dependent resources.
  - **count:** If a resource or module block includes a count argument whose value is a whole number, Terraform will create that many instances. count is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.
  - **for_each:** If a resource or module block includes a for_each argument whose value is a map or a set of strings, Terraform will create one instance for each member of that map or set. for_each is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.
  - **provider:** The provider meta-argument specifies which provider configuration to use for a resource, overriding Terraform's default behavior of selecting one based on the resource type name. Its value should be an unquoted <PROVIDER>.<ALIAS> reference.
  - **lifecycle:** The general lifecycle for resources is described in the Resource Behavior page. Some details of that behavior can be customized using the special nested lifecycle block within a resource block body.
    - create_before_destroy
    - prevent_destroy
    - ignore_changes
  - **provisioners & connections:** For taking extra actions after resource creation (Example: install some app on server or do something on local desktop after resource is created at remote destination)
- When to use **for_each** instead of **count**?
  - If your instances are almost identical, count is appropriate. If some of their arguments need distinct values that can't be directly derived from an integer, it's safer to use for_each.
  ```
  variable "subnet_ids" {
    type = list(string)
  }

  resource "aws_instance" "server" {
    # Create one instance for each subnet
    count = length(var.subnet_ids)

    ami           = "ami-a1b2c3d4"
    instance_type = "t2.micro"
    subnet_id     = var.subnet_ids[count.index]

    tags = {
      Name = "Server ${count.index}"
    }
  }
  ```
# Multiple Provisioners of various types
- By default, prvisioners run when the resources are defined with in created.
- Creation-time provisioners only run during creation, not during updating or any other lifecycle.
- They are meant as a means to perform bootstrapping of a system.
- If a creation-time provisioner fails, the resource is marked as tainted.
- A tainted resource will be planned for destruction and recreation upon the next terraform apply.
- Terraform does this because a failed provisioner can leave a resource in a semi-configured state.
- Because Terraform can't reason about what the provisioner does, the only way to ensure peoper creation of a resource is to recretae it. This is tainting.
- You can change this behavior by setting the on_failure attribute.
```
provisioner "file" {
  source = "apps/index.html"
  destination = "/tmp/index.html"
  on_failure = continue #fail
}
```

## References
- [Meta-arguments](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)