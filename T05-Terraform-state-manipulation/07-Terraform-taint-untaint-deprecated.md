# Terraform taint/untaint
- These commands helps us to force recreate the resources.
- **terraform taint** command manually marks a terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
- This command is deprecated, because there are better alternatives available in Terraform v0.15.2 and later. See below for more details.
- **terraform untaint**
  - The terraform untaint command manually unmarks a terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
  - This reverses either a manual terraform taint or the result of provisioners failing on a resource.
  - This command will not modify infrastructure, but does modify the state file in order to unmark a resource as tainted.
```
# List terraform managed resources from state file
- terraform state list

# Taint a specific resource from the above list
- terraform taint aws_instance.web --> it marked the resource as taint

# Now lets check the changes with #terraform plan and see what it does to the tainted resource it shows taint resource should be "-/+ destroy and the create replacement" and "resource is tainted, so must be replaced" statement

# Optional: lets untaint the same resource which we did and observe changes with #terraform plan

# Based on review use #terraform apply [-auto-approve]
```

```
root@terraformworkstation:~/terraform-aws/variables/input# terraform state list
aws_instance.web
aws_security_group.allow_http_ssh
aws_security_group_rule.egress_allow_all
aws_security_group_rule.ingress_http
aws_security_group_rule.ingress_ssh
root@terraformworkstation:~/terraform-aws/variables/input# terraform taint aws_security_group_rule.egress_allow_all
Resource instance aws_security_group_rule.egress_allow_all has been marked as tainted.
root@terraformworkstation:~/terraform-aws/variables/input#
root@terraformworkstation:~/terraform-aws/variables/input# terraform plan
aws_security_group.allow_http_ssh: Refreshing state... [id=sg-0beef3069dce98cc4]
aws_security_group_rule.ingress_ssh: Refreshing state... [id=sgrule-1001355491]
aws_security_group_rule.ingress_http: Refreshing state... [id=sgrule-2368021846]
aws_security_group_rule.egress_allow_all: Refreshing state... [id=sgrule-2496757373]
aws_instance.web: Refreshing state... [id=i-0ef794b849e691d7c]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_security_group_rule.egress_allow_all is tainted, so must be replaced
-/+ resource "aws_security_group_rule" "egress_allow_all" {
      ~ id                       = "sgrule-2496757373" -> (known after apply)
      - ipv6_cidr_blocks         = [] -> null
      - prefix_list_ids          = [] -> null
      + source_security_group_id = (known after apply)
        # (7 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform
apply" now.
```

```
root@terraformworkstation:~/terraform-aws/variables/input# terraform state list
aws_instance.web
aws_security_group.allow_http_ssh
aws_security_group_rule.egress_allow_all
aws_security_group_rule.ingress_http
aws_security_group_rule.ingress_ssh
root@terraformworkstation:~/terraform-aws/variables/input# terraform taint aws_security_group_rule.egress_allow_all
Resource instance aws_security_group_rule.egress_allow_all has been marked as tainted.
root@terraformworkstation:~/terraform-aws/variables/input# terraform plan
aws_security_group.allow_http_ssh: Refreshing state... [id=sg-0beef3069dce98cc4]
aws_security_group_rule.ingress_ssh: Refreshing state... [id=sgrule-1001355491]
aws_security_group_rule.ingress_http: Refreshing state... [id=sgrule-2368021846]
aws_security_group_rule.egress_allow_all: Refreshing state... [id=sgrule-2496757373]
aws_instance.web: Refreshing state... [id=i-0ef794b849e691d7c]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # aws_security_group_rule.egress_allow_all has been changed
  ~ resource "aws_security_group_rule" "egress_allow_all" {
        id                = "sgrule-2496757373"
      + ipv6_cidr_blocks  = []
      + prefix_list_ids   = []
        # (7 unchanged attributes hidden)
    }

Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan
may include actions to undo or respond to these changes.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_security_group_rule.egress_allow_all is tainted, so must be replaced
-/+ resource "aws_security_group_rule" "egress_allow_all" {
      ~ id                       = "sgrule-2496757373" -> (known after apply)
      - ipv6_cidr_blocks         = [] -> null
      - prefix_list_ids          = [] -> null
      + source_security_group_id = (known after apply)
        # (7 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform
apply" now.
root@terraformworkstation:~/terraform-aws/variables/input# terraform untaint aws_security_group_rule.egress_allow_all
Resource instance aws_security_group_rule.egress_allow_all has been successfully untainted.
root@terraformworkstation:~/terraform-aws/variables/input# terraform plan
aws_security_group.allow_http_ssh: Refreshing state... [id=sg-0beef3069dce98cc4]
aws_security_group_rule.egress_allow_all: Refreshing state... [id=sgrule-2496757373]
aws_security_group_rule.ingress_http: Refreshing state... [id=sgrule-2368021846]
aws_security_group_rule.ingress_ssh: Refreshing state... [id=sgrule-1001355491]
aws_instance.web: Refreshing state... [id=i-0ef794b849e691d7c]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # aws_security_group_rule.egress_allow_all has been changed
  ~ resource "aws_security_group_rule" "egress_allow_all" {
        id                = "sgrule-2496757373"
      + ipv6_cidr_blocks  = []
      + prefix_list_ids   = []
        # (7 unchanged attributes hidden)
    }

Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan
may include actions to undo or respond to these changes.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

No changes. Your infrastructure matches the configuration.

Your configuration already matches the changes detected above. If you'd like to update the Terraform state to match, create and apply a
refresh-only plan:
  terraform apply -refresh-only
root@terraformworkstation:~/terraform-aws/variables/input#
```