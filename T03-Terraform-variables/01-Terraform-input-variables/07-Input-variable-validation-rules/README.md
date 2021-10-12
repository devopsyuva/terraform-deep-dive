# Terraform Custom Validation rules for variables
- Terraform language includes a number of built-in functions that you can call from within expressions to transform and combine values.
  - Length Function
  - Substr Function
- Custom Validation Rules
```
#Sample validation with and operation:
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

#Sample validation with OR operation:
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = can(regex("^ami-", var.image_id)) || substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\" or \"zsv-\"."
  }
}
```

## References
- [Functions](https://www.terraform.io/docs/language/functions/index.html)
- [Custom rules](https://www.terraform.io/docs/language/values/variables.html#custom-validation-rules)