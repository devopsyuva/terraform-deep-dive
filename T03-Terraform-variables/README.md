# Terraform Variables
- We have three types:
  - Input Variables
  - Output Values
  - Local Values
- **Input Variables:** These are serve as parameters for a terraform module, allowing aspects of the module to be customized without aletring the module's own source code, and allowing modules to be shared between different configurations.
- **Output Values:** These are like the return values of a terraform module and have several uses.
- **Local Values:** Its works more of DRY(Don't Repeat Yourself) principle. These will assigns a name to an expression, so you can use that name multiple times within a module without repeating it.
- Types:
  - String: a sequence of Unicode characters representing some text, like "hello"
  - number: a number value, like 6.3145
  - bool: a boolean value, like true or false
  - list (or tuple): a sequence of values, like ["sudheer", "sandeep"]. These are identified by consecutive whole numbers, starting from zero 
  - map (or object): a group of values identified by named labels, like {name = "sudheer", age = 30}
  - null: a value that represents absence or omission

## References
- [Input Variables](https://www.terraform.io/docs/language/values/variables.html)
- [Output Values](https://www.terraform.io/docs/language/values/outputs.html)
- [Local Values](https://www.terraform.io/docs/language/values/locals.html)
- [Types](https://www.terraform.io/language/expressions/types)