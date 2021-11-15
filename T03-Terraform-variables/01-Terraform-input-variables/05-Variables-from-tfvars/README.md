# Terraform Input Variables from terraform.tfvars
- Now variables key=value will be stored in "terraform.tfvars" and variables will be defined in "variables.tf" file.
- Lets provide default values in "variables.tf" file and see if values will be auto loaded with values defined in "terraform.tfvars".
```
#Scenario 1 with terraform.tfvars
>terraform plan --> To check the values are picked from the file "terraform.tfvars"
>terraform apply

#Scenario 2 with ec2.tfvars
>terraform plan -var-file=ec2.tfvars --> Check if values are loaded from file "ec2.tfvars"
>terraform apply -var-file=ec2.tfvars

#Scenario 3 with ec2.auto.tfvars
>terraform plan
>terraform apply [-auto-approve]
```