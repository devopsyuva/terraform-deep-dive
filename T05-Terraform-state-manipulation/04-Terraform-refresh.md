# Terraform refresh

**The terraform refresh command reads the current settings from all managed remote objects and updates the Terraform state to match.**

- Terraform refresh command is used to reconcile the state Terraform know about (via its state file) with the real-world infrastructure.
- This is used to defect any drift from the last-know state, and to update the state file.
- This doesn't modify infrastructure, but does modify the state file. if the state is changed, this may cause changes to occur during the next plan or apply.
- **Desired State:** means terraform configuration files (.tf) used to create the resources.
- **Current State:** actual resources created on the respective provider Infrastructure.

## Scenario 1:
1) Do changes to any resource which was actually created by terraform configuration like to add new tags from AWS console.
2) Lets run **#terraform plan** to see if these are reflected to make a decision about update in-place. But it will not update in terraform.tfstate file.
3) Now execute **#terraform refresh** to capture the real-world changes to update the "terraform.tfstate" file.
4) Since the state was not updated, **#terraform apply** will do the changes(remove the tag in this case) to occur in terraform.tfstate file with real-world resource.

Note:
- what happens, when we do not run **#terraform refresh** and apply it directly.

## Need?
1) There are changes happened in your infrastructure manually and not via terraform.
2) Now decision to be made if want those changes or not.
    - if you don't want those changes proceed with **#terraform apply** so manually changes we have done on out cloud resources will be removed.
    - if you want those changes, execute **#terraform refresh** command to update **terraform.tfstate** file about changes and embed them in your terraform manifests and proceed with flow.
- Few sample outputs for above flow, to understand the scenario:
```
root@terraformworkstation:~/terraform-aws/state-locking# terraform plan
Acquiring state lock. This may take a few moments...
aws_instance.web[0]: Refreshing state... [id=i-02507c9b5f29328b8]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # aws_instance.web[0] has been changed
  ~ resource "aws_instance" "web" {
        id                                   = "i-02507c9b5f29328b8"
      ~ tags                                 = {
          + "Version" = "v1.0"
            # (3 unchanged elements hidden)
        }
      ~ tags_all                             = {
          + "Version" = "v1.0"
            # (3 unchanged elements hidden)
        }
        # (27 unchanged attributes hidden)





        # (5 unchanged blocks hidden)
    }

Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan
may include actions to undo or respond to these changes.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

No changes. Your infrastructure matches the configuration.

Your configuration already matches the changes detected above. If you'd like to update the Terraform state to match, create and apply a
refresh-only plan:
  terraform apply -refresh-only
Releasing state lock. This may take a few moments...
root@terraformworkstation:~/terraform-aws/state-locking# terraform refresh
Acquiring state lock. This may take a few moments...
aws_instance.web[0]: Refreshing state... [id=i-02507c9b5f29328b8]
Releasing state lock. This may take a few moments...
root@terraformworkstation:~/terraform-aws/state-locking# terraform plan
Acquiring state lock. This may take a few moments...
aws_instance.web[0]: Refreshing state... [id=i-02507c9b5f29328b8]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
Releasing state lock. This may take a few moments...
root@terraformworkstation:~/terraform-aws/state-locking#
```