# Terraform AWS resources creation
- First lets define the AWS provider details in file "provider.tf" with sections mentioned below:
  - Provider Requirements
  - Provider Configuration
  - Dependency lock file
- When ever we have changed the version under required_providers, we need to run command mentioned below:
```
#terraform init --upgrade
```
- After that, we have create a resources on AWS (current provider for this examples) like Instances, VPC etc.,
- We have created single file "main.tf" for all resources.
- Final task is to run init, plan and apply.
```
#terraform init
#terraform plan
#terraform apply [-auto-approve]
```
- Check the resources on respective AWS console with the resources created.
- Cleanup all after successful creation
```
#terraform destroy -auto-approve
```
- From terraform registry (registry.terraform.io) we can download both providers and modules.
- Terraform provider badges to official providers and modules which are owned and maintained by terraform
  - Official badge
  - Verified badge
  - Community badge
  - Archived badge

# AWS authentication types:
- Static credentials
- Environment variables
- Shared credentials/configuration file
- CodeBuild, ECS, and EKS Roles
- EC2 Instance Metadata Service (IMDS and IMDSv2)

# Terraform Resources
- **Language Syntax**
- **Resource Block**
  - create
  - update
  - re-create
  - destroy
- **Resource Behaviour**
- **State Fundamentals**
- **Resource meta-data arguments**
  - depends_on
    - if defined, must be a list of references to other resources or child modules in the same calling module.
    - arbitrary expressions are not allowed in the depends_on arguments value, because its value must be known before Terraform knows resource relationships.
  - count
  - for_each
  - provider
  - lifecycle
    - create_before_destroy
    - prevent_destroy
    - ignore_changes
- **Provisioners and Connections**

## Note
- **source** section in required_providers block of terraform settings will download to local machine from where we run #terraform commands
- Source address syntax #[\<HOSTNAME\>\/]\<NAMESPACE\>/\<TYPE\>
  - Example for hashicorp registry #registry.terraform.io/hashicorp/aws

## References
- [AWS Authentication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Resources Overview](https://www.terraform.io/docs/language/resources/index.html)