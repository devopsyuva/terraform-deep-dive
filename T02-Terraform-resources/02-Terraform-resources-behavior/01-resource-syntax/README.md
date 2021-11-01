# Terraform Resource Behavior
- **create resource:** will be created on the respective provider as per configuration files defined in workspace.
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create
```
- **destroy resource:** will cleanup the resource created on the provider by terraform workspace. Here **terraform.tfstate** file will have local info for resource created. If there is no configration file for which resources are created, so terraform will use state file to cleanup the resources.
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  - destroy
```
- **update resource:** will modify the resources which are created earlier by terraform and looks to update/change the arrguments of the provider resource.
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  ~ update in-place
```
- **recreate resource:** will destroy and create resource for the once it can't be updated on the provider due to API limitations.
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
-/+ destroy and then create replacement
```

# Terraform flow
- First run, **terraform init** command to install the aws provider plugin to local system where we are running terrform cli operations.
  - Above command will create two files ".terraform" folder and ".terraform.hcl.lock" file.
  - .terraform folder will have provider downloaded plugin.
  - .terraform.lock.hcl file which will have provider specific hashes and version details.
- Then validate the configuration files for syntax check using command **terraform validate**.
- Lets check the format and style on configuration files written to create the resources using command **terraform fmt**. When ever files are formated it will display the file names as output.
- Now lets execute the plan/preview before actual resources created on the target provider using command **terraform plan**.
- Now gohead and create the resource using **terraform apply \[-auto-approve\]**.
  - It will create a file called ".terraform.tfstate".
  - This file is reference to the actual resource created on the provider.
  - It can be stored in remote location as well with locking.
  - +create,-destroy,~update-in-place,-/+recreate. These details can be seen in #terraform plan.
  - **Desired state:** What resource to be created on the provider as per .tf configuration files.
  - **Current state:** resources that are created on the target provider.
- After all verification are done, if you want to cleanup the resources created by terraform on target provider execute command **terraform destroy**.
- Additionally, we can remove the files "rm -rf .terraform*" and "rm -rf .terraform.tfstate*".