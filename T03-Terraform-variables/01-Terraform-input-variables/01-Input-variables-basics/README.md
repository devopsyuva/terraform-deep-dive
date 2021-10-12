# Input Variables Basics
- To define default variables for resources creation are defined in variables.tf file.
- These values will be picked in resource block using #var.\<var_name\>.
```
variable "aws_region" {
    description = "Region on which resources will be created"
    type = string
    default = "us-east-1"
}

var.aws_region = "us-east-1"
```
- Terraform CLI defines the following optional arguments for variable declarations:
  - **default** - A default value which then makes the variable optional.
  - **type** - This argument specifies what value types are accepted for the variable.
    - string
    - list(string)
    - number
    - bool
    - map(string)
  - **description** - This specifies the input variable's documentation.
  - **validation** - A block to define validation rules, usually in addition to type constraints.
  - **sensitive** - Limits Terraform UI output when the variable is used in configuration.
- Custom Validation rules
```
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}
```

## References
- [Input Variables](https://www.terraform.io/docs/language/values/variables.html)