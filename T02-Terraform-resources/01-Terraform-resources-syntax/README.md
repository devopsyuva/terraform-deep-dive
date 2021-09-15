# Terraform Resource Syntax
- Inorder to create resources on specific provider, we have to define resource block in "main.tf" file or any specific file with .tf as extension.
- Top/Parent level blocks like resource, provider etc., and Low/Child level blocks like tags, provisioners etc.,
```
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}

<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}

#For example
aws_vpc --> resource type, defends on provider we are using
main --> resource local name should be unique
cidr_block --> Rource arguments
```

## References
- [Terraform Language](https://www.terraform.io/docs/language/index.html)