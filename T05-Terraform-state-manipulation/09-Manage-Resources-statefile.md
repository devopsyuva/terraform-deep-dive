# Replace a resource with CLI
- Terraform usually only updates your infrastructure if it does not match your configuration.
- So we can use the -replace flag for #terraform plan/apply operations to safely recreate resources in environment even if you have not edited the configuration.
- Replacing a resource is also useful in cases where a user manually changes a setting on a resource or when you need to update a provisioning script.
- This allows you to rebuild specific resources and avoid a full terraform destroy operation on your configuration.
- The -replace flag allows you to target specific resources and avoid destroying all the resources in your workspace just to fix one of them.
- Note: In older versions of Terraform, you may have used the terraform taint command to achieve a similar outcome. That command has now been deprecated in favor of the -replace flag, which allows for a simpler, less error-prone workflow.

### References:
- [CLI Operations](https://learn.hashicorp.com/collections/terraform/cli)