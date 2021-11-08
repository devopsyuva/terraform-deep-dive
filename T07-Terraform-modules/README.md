# Terraform Modules
- Modules are containers for multiple resources that are used together.
- A module consists of a collection of .tf files kept together in a directory.
- Modules are the main way to package and reuse resource configurations with Terraform.
- Every Terraform configuration has at least one module, known as its root module, which consists of the resources defined in the .tf files in the main working directory.
- A Terraform module can call other modules to include their resources into the configuration.
- A module that has been called by another module is often referred to as a child module.
- Child modules can be called multiple times within the same configuration, and multiple configurations can use the same child module.
- In addition to modules from the local filesystem, terraform can load modules from a public or private registry.
- This makes it possible to publish modules for others to use, and to use modules that others have published.
- Public modules can be picked from terraform registry(registry.terraform.io).
- Terraform Cloud and Enterprise both include a private module registry for sharing modules internally within the organization.

# Terraform Module to taint resource
- The taint command can be used to taint specific resources within a module.
- It is not possible to taint an entire module. Instead, each resource within the module must be tainted separately.
```
#List resources from state after creating the resource using terraform apply
terraform state list

#Taint a resource with terraform taint <RESOURCE_NAME>
terraform taint module.ec2_cluster.aws_instance.this[0]

#Terraform plan
terraform plan --> First VM will be destroyed and re-created

#Terraform apply
terraform apply -auto-approve
```

# Terraform Module with Meta-arguments
- count
- for_each
- providers
- depends_on

# Terrform get for modules
- The terraform get command is used to download and update modules mentioned in the root module.
- Both the **terraform get and terraform init** commands will install and update modules.
- The **terraform init** command will also initialize backends and install plugins.
```
# Delete modules in .terraform folder
ls -lrt .terraform/modules
rm -rf .terraform/modules

# Terraform Get
terraform get
ls -lrt .terraform/modules
```

### References
- [Module Development](https://www.terraform.io/docs/language/modules/develop/index.html)
- [Module Meta-arguments](https://www.terraform.io/docs/language/meta-arguments/module-providers.html)
- [Terraform get](https://www.terraform.io/docs/cli/commands/get.html)