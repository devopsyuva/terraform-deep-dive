# Terraform Input Variables
- Basic input variables.
- Provide Input variables when prompted during #terraform plan/apply command.
- Override default variable values using CLI argument "-var".
- Override default variable values using Environment Variables (TF_var_aa).
- Provide Input variables using terraform.tfvars files.
- Provide Input variables using \<any_name\>.tfvars file with CLI argument "-var-file".
- Provide Input variables using auto.tfvars files.
- Implement complex type constructors like List & Map in Input variables.
- Implement custom Validation rules in variables.
- Protect Sensitive Input variables.
- File Function

- [Terraform Variables](../../src/images/terraform-variables.png)

# Terraform optional arguments for variable declarations
- **default** - A default value which then makes the variable optional.
- **type** - This argument specifies what value types are accepted for the variable.
- **description** - This specifies the input variable's documentation.
- **validation** - A block to define validation rules, usually in addition to type constraints.
- **sensitive** - Limits Terraform UI output when the variable is used in configuration.

# Terraform Variable Definition Precendence
- Terraform loads variables in the following order, with later sources taking precedence over earlier ones:
  - Environment variables
  - The terraform.tfvars file, if present.
  - The terraform.tfvars.json file, if present.
  - Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
  - Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

## References
- [Input Variables](https://www.terraform.io/docs/language/values/variables.html)
- [File Function](https://www.terraform.io/docs/language/functions/file.html)