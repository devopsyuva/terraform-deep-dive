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
```

## Scenario 2 to test
```
#Create new workspace
terraform workspace new dev

#Verify the folder
cd terraform.tfstate.d
ls -l --> should display dev directory as per name passed above
cd dev && ls -l --> To check/list files in dev directory

#Terraform plan and apply
terraform plan --> will show as it creats only one instance since other than default workspace it uses 1

terraform apply [-auto-approve]

#After apply, check state file was created for dev workspace under "terraform.tfstate.d/dev"
```

## Scenario 3 to test
```
#Show current workspace
terraform workspace show

#List workspaces
terraform workspace list

#select workspace to switch to dev from default
terraform workspace select dev

#Create Resource for specified environment workspace
terraform apply [-auto-approve]

#Delete resources from default workspace
terraform destroy [-auto-approve]

#verify if all resources related to default workspace are cleaned up
```

## Scenario 4 to test
```
#we can't delete default workspace from terraform
#Switch to other workspace and delete the workspace which you want apart from one we are currently active.

terraform workspace show
terraform workspace delete dev --> First we have to delete the resources and then remove the workspace which results in dangling resources.
terraform workspace show --> check if still that workspace exists
```