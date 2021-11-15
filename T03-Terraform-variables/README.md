# Terraform Variables
- We have three types:
  - Input Variables
  - Output Values
  - Local Values
- **Input Variables:** These are serve as parameters for a terraform module, allowing aspects of the module to be customized without aletring the module's own source code, and allowing modules to be shared between different configurations.
- **Output Values:** These are like the return values of a terraform module and have several uses.
- **Local Values:** Its works more of DRY(Don't Repeat Yourself) principle. These will assigns a name to an expression, so you can use that name multiple times within a module without repeating it.

## References
- [Input Variables](https://www.terraform.io/docs/language/values/variables.html)
- [Output Values](https://www.terraform.io/docs/language/values/outputs.html)
- [Local Values](https://www.terraform.io/docs/language/values/locals.html)