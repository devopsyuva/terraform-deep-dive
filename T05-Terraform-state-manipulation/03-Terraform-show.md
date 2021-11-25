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

```
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# ls -l
total 16
-rw-r--r-- 1 root root 3101 Nov 22 15:35 instanceplan.out
-rw-r--r-- 1 root root  246 Nov 19 15:38 instance.tf
-rw-r--r-- 1 root root  467 Nov 22 15:20 provider.tf
-rw-r--r-- 1 root root  647 Nov 22 15:05 variables.tf
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# mkdir /tmp/backup
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# mv *.tf /tmp/backup/
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# ls -al
total 20
drwxr-xr-x 3 root root 4096 Nov 22 15:37 .
drwxr-xr-x 3 root root 4096 Nov 19 15:35 ..
-rw-r--r-- 1 root root 3101 Nov 22 15:35 instanceplan.out
drwxr-xr-x 3 root root 4096 Nov 22 15:20 .terraform
-rw-r--r-- 1 root root 1106 Nov 19 15:39 .terraform.lock.hcl
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage#
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# ls -l
total 4
-rw-r--r-- 1 root root 3101 Nov 22 15:35 instanceplan.out
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform apply "instanceplan.out"
Acquiring state lock. This may take a few moments...
aws_instance.web[0]: Creating...
aws_instance.web[0]: Still creating... [10s elapsed]
aws_instance.web[0]: Still creating... [20s elapsed]
aws_instance.web[0]: Still creating... [30s elapsed]
aws_instance.web[0]: Still creating... [40s elapsed]
aws_instance.web[0]: Creation complete after 44s [id=i-0d49e0d975fb13a95]
Releasing state lock. This may take a few moments...

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# ls -l /tmp/backup/
total 12
-rw-r--r-- 1 root root 246 Nov 19 15:38 instance.tf
-rw-r--r-- 1 root root 467 Nov 22 15:20 provider.tf
-rw-r--r-- 1 root root 647 Nov 22 15:05 variables.tf
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage#

```

### References:
- [Terraform plan](https://www.terraform.io/docs/cli/commands/plan.html#out-filename)
- [Terraform show](https://www.terraform.io/docs/cli/commands/show.html)