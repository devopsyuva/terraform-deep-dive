# Terraform Local Values
- Terraform local values works more to apply DRP(Don't Repeat Principle).
- A local value assigns a name to an expression, so you can use that name multiple times within a module without repeating it.
- A local values are like a functions temporary local variables.
- Once a local value is declared, you can reference it in expressions as local.\<NAME\>.
- Local values are immutable in runtime while executing terraform plan/apply/destroy. Unlike input variables, locals are not set directly by users of your configuration.
```
locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
}
```
- Lets see how to use local values as mentioned below
```
resource "aws_instance" "example" {
  # ...

  tags = local.common_tags
}
```
- The ability to easily change the value in a central place is the key advantage of local values.
- Use local values only in moderation.

## References
- [Local Values](https://www.terraform.io/docs/language/values/locals.html)