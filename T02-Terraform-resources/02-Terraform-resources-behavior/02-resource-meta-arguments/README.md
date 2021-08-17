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
## References
- [Meta-arguments](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)