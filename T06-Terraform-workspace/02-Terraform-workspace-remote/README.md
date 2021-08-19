## Scenario 1 to test
```
#Initialize terraform
terraform init

#List workspaces
terraform workspace list --> * will be displayed for current used workspace

#Output current workspace using show
terraform workspace show

#Terraform plan
terraform plan --> for default it should show 2 instances creation

#review and apply
terraform apply [-auto-approve]

#check if all instances are created as per specified in default workspace value

#Now check the s3 bucket to see if workspace was created to store state file

#terraform workspace new dev --> check the bucket to see a new folder structure was created (bucket-name/env:/dev/workspaces/terraform.tfstate) file got created

#Optional: terraform workspace new qa --> check the bucket to see a new folder structure was created (bucket-name/env:/qa/workspaces/terraform.tfstate) file got created
```