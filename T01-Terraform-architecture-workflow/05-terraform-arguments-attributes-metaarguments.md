# Terraform Arguments
- Arguments configure a particular resource; because of this, many arguments are resource-specific.
- Arguments can be required or optional, as specified by the provider. If you do not supply a required argument, Terraform will give an error and not apply the configuration.

# Terraform Attributes
- Attributes are values exposed by an existing resource. References to resource attributes take the format resource_type.resource_name.attribute_name.
- Unlike arguments which specify an infrastructure object's configuration, a resource's attributes are often assigned to it by the underlying cloud provider or API.

# Terraform Meta-arguments
- Meta-arguments change a resource's behavior, such as using a count meta-argument to create multiple resources.
- Meta-arguments are a function of Terraform itself and are not resource or provider-specific.
- Example: for_each, count, depends_on, provider, and life-cycle

## References
- [Arguments](https://www.terraform.io/docs/language/syntax/configuration.html#arguments)
- [Attributes](https://learn.hashicorp.com/tutorials/terraform/resource?in=terraform/configuration-language#review-the-random_pet-resource)
- [Meta-arguments](https://www.terraform.io/docs/language/resources/syntax.html#meta-arguments)