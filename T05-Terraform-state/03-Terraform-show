- Terraform state command is used to review the terraform plan files.
- It will display human-readable output from a state or plan file.
- Terraform plan files are binary files, which we can read only through #terraform show command.

Scenario:
- terraform init --> Initialize terraform
- terraform plan -out=ec2-plan.out --> To create plan
- terraform show ec2-plan.out --> Read the plan file
- terraform show -json ec2-plan.out --> Read the plan in JSON format
- terraform show --> By default it will read the state file "terraform.tfstate" in local workspace or remote after executing "terraform apply" command