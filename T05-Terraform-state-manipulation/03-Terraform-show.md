# Terraform show command for plan, configuration, and current state
- Inorder to print output of the state or plan file in human-readable format.
- It shows what resources have been planned/created (current state) in the infrastructure as per desired configuration files.
- Terraform plan files are binary files, which needs "show" subcommand to read the plan file.
- Meachine readable output will be generated with the help of "-json" CLI option.
- Any sensitive information with "-json" will be printed in plain text.

## How to review terraform plan files?
```
# Initialize Terraform
- terraform init

# Create Plan
- terraform plan -out=instanceplan.out

# Read the plan files
- terraform show instanceplan.out

# Read the plan in JSON format
- terraform show -json instanceplan.out

# Reads "terraform.tfstate" file by default
- terraform show --> By default it will read the state file "terraform.tfstate" in local workspace or remote after executing "terraform apply" command
```

### References:
- [Terraform plan](https://www.terraform.io/docs/cli/commands/plan.html#out-filename)
- [Terraform show](https://www.terraform.io/docs/cli/commands/show.html)