# Terraform Protecting Input Variables
- There might be some sensitive variables which should not display the value when we run in input, output etc while executing commands #terraform plan/apply etc.,
- When using Environment variables for terraform with TF_VAR-* it will store details on the terminal and we can view details by running printenv/history command.
- Terraform will detect these values which are marked as **sensitive** in command output and log files, and raise an error when it dects that they will be exposed in other ways.
```
variable "password" {
  type        = string
  description = "The id of the machine image to use for the server."
  sensitive = true
}
```
## Note
- But password details in this example can be seen in terraform.tfstate file which should be protected as well.
### References
- [Sencitive Variables](https://www.terraform.io/docs/language/values/variables.html#suppressing-values-in-cli-output)
- [Examples](https://learn.hashicorp.com/tutorials/terraform/sensitive-variables?in=terraform/configuration-language&utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS)