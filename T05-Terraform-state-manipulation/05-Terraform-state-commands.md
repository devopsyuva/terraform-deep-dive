# Terraform state uses these options list, show, rm, replace-provider, and mv(move)
- **list** option is used to list resources within a terraform state.
- **show** option is used to show the attributes of a single resource in the terraform state.
- **mv** option used to move an item matched by the address given to the destination address. This command can also move to a destination address in a completely different state file.
- **rm** option used to remove the resource from the record so that Terraform will no longer track the corresponding remote object.
- **replace-provider** used to update the provider details.

```
#terraform state list
aws_instance.web

#terraform state show aws_instance.web

#terraform state mv [--dry-run] aws_instance.web aws_instance.ec2_demo. This will update the state file as well not desired resource configuration files.

It should create a backup file of terraform.tfstate as something like terraform.tfstate.116745629.backup

It also renames the name of the resource in the state file Always run #terraform plan command to see if it causes any issue with the resource that are created on target.

#terraform state rm 'aws_instance.web'

#terraform state replace-provider hashicorp/aws registry.acme.corp/acme/aws
```

- Terraform move sample output
```
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform state mv aws_instance.web aws_instance.demo
Acquiring state lock. This may take a few moments...
Move "aws_instance.web" to "aws_instance.demo"
Successfully moved 1 object(s).
Releasing state lock. This may take a few moments...
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage#
```

- Terraform remove resource handled through
```
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform state list
aws_instance.demo[0]
aws_instance.demo[1]
aws_instance.demo[2]
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform state rm aws_instance.demo[2]
Acquiring state lock. This may take a few moments...
Removed aws_instance.demo[2]
Successfully removed 1 resource instance(s).
Releasing state lock. This may take a few moments...
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform state list
aws_instance.demo[0]
aws_instance.demo[1]
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage#
```