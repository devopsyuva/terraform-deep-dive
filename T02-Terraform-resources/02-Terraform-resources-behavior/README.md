# Terraform Resource Behavior
- **create resource:** will be created on the respective provider as per configuration files defined in workspace.
- **destroy resource:** will cleanup the resource created on the provider by terraform workspace. Here **terraform.tfstate** file will have local info for resource created. If there is no configration file for which resources are created, so terraform will use state file to cleanup the resources.
- **update resource:** will modify the resources which are created earlier by terraform and looks to update/change the arrguments of the provider resource.
- **recreate resource:** will destroy and create resource for the once it can't be updated on the provider due to API limitations.