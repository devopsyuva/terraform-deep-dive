# required_version
- required_version parameter is used to specify required terraform version in our configuration.
- what happens, when terraform required_version value is not matching with current terraform version installed? --> It produces error and exit without taking any further actions.
- What happens when each module specifies required_version? --> requirement of all modules should be satisfied.
- Terraform's resource types are implemented by provider plugins, whose release cycles are independent of Terraform CLI and of each other.

# required_provider
- required_providers block specifies all of the providers required by the current module, mapping each local provider name to a source address and a version constraint.
- Each Terraform module must declare which providers it requires, so that Terraform can install and use them.
- Downloaded Plugin for specified provider will be saved under following path
  - .terraform/providers/plugins/
- Each Provider has two identifiers: unique source address and local name.
  - source address syntax: "\[\<HOSTNAME>\/\]\<NAMESPACE\>\/\<TYPE\>"
- [Provider](https://www.terraform.io/docs/language/providers/requirements.html)
