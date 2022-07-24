# Terraform taint/untaint
- These commands helps us to force recreate the resources.
- **terraform taint** command manually marks a terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
- This command is deprecated, because there are better alternatives available in Terraform v0.15.2 and later. See below for more details.
- New option to use: terraform apply -replace="aws_instance.example[0]"
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
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# terraform state list
aws_instance.demo[0]
aws_instance.demo[1]
aws_instance.demo[2]
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# terraform taint aws_instance.demo[1]
Acquiring state lock. This may take a few moments...
Resource instance aws_instance.demo[1] has been marked as tainted.
Releasing state lock. This may take a few moments...
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# terraform plan
Acquiring state lock. This may take a few moments...
aws_instance.demo[2]: Refreshing state... [id=i-072b43c790a120c06]
aws_instance.demo[1]: Refreshing state... [id=i-0ea07a8024405cfde]
aws_instance.demo[0]: Refreshing state... [id=i-01337f85072615992]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_instance.demo[1] is tainted, so must be replaced
-/+ resource "aws_instance" "demo" {
      ~ arn                                  = "arn:aws:ec2:us-east-1:017187748261:instance/i-0ea07a8024405cfde" -> (known after apply)
      ~ associate_public_ip_address          = true -> (known after apply)
      ~ cpu_core_count                       = 1 -> (known after apply)
      ~ cpu_threads_per_core                 = 1 -> (known after apply)
      ~ disable_api_termination              = false -> (known after apply)
      ~ ebs_optimized                        = false -> (known after apply)
      - hibernation                          = false -> null
      + host_id                              = (known after apply)
      ~ id                                   = "i-0ea07a8024405cfde" -> (known after apply)
      ~ instance_initiated_shutdown_behavior = "stop" -> (known after apply)
      ~ instance_state                       = "running" -> (known after apply)
      ~ ipv6_address_count                   = 0 -> (known after apply)
      ~ ipv6_addresses                       = [] -> (known after apply)
      + key_name                             = (known after apply)
      ~ monitoring                           = false -> (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      ~ primary_network_interface_id         = "eni-0cb4329fb92c3740b" -> (known after apply)
      ~ private_dns                          = "ip-172-31-26-172.ec2.internal" -> (known after apply)
      ~ private_ip                           = "172.31.26.172" -> (known after apply)
      ~ public_dns                           = "ec2-50-17-127-51.compute-1.amazonaws.com" -> (known after apply)
      ~ public_ip                            = "50.17.127.51" -> (known after apply)
      ~ secondary_private_ips                = [] -> (known after apply)
      ~ security_groups                      = [
          - "default",
        ] -> (known after apply)
      ~ subnet_id                            = "subnet-a3c120ef" -> (known after apply)
        tags                                 = {
            "Env"  = "Production"
            "Name" = "WebApp-terraform"
        }
      ~ tenancy                              = "default" -> (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      ~ vpc_security_group_ids               = [
          - "sg-7578266f",
        ] -> (known after apply)
        # (6 unchanged attributes hidden)

      ~ capacity_reservation_specification {
          ~ capacity_reservation_preference = "open" -> (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      ~ enclave_options {
          ~ enabled = false -> (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      ~ metadata_options {
          ~ http_endpoint               = "enabled" -> (known after apply)
          ~ http_put_response_hop_limit = 1 -> (known after apply)
          ~ http_tokens                 = "optional" -> (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      ~ root_block_device {
          ~ delete_on_termination = true -> (known after apply)
          ~ device_name           = "/dev/xvda" -> (known after apply)
          ~ encrypted             = false -> (known after apply)
          ~ iops                  = 100 -> (known after apply)
          + kms_key_id            = (known after apply)
          ~ tags                  = {} -> (known after apply)
          ~ throughput            = 0 -> (known after apply)
          ~ volume_id             = "vol-02b31052a624328b7" -> (known after apply)
          ~ volume_size           = 8 -> (known after apply)
          ~ volume_type           = "gp2" -> (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 1 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
Releasing state lock. This may take a few moments...
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# terraform untaint aws_instance.demo[1]
Acquiring state lock. This may take a few moments...
Resource instance aws_instance.demo[1] has been successfully untainted.
Releasing state lock. This may take a few moments...
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# terraform plan
Acquiring state lock. This may take a few moments...
aws_instance.demo[1]: Refreshing state... [id=i-0ea07a8024405cfde]
aws_instance.demo[0]: Refreshing state... [id=i-01337f85072615992]
aws_instance.demo[2]: Refreshing state... [id=i-072b43c790a120c06]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
Releasing state lock. This may take a few moments...
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery#
```