# Terraform State Disaster Recovery

## Terraform state pull/push
- terraform state pull is used to manually download and output the state from remote state.
  - This also works with local state.
  - This command will download the state from its current location and output the raw format to stdout.
- terraform state push is used to manually upload the local state file to remote state.
- Terraform will perform a number of safety checks to prevent you from making changes that appear to be unsafe:
  - **Differing lineage:** If the "lineage" value in the state differs, Terraform will not allow you to push the state. A differing lineage suggests that the states are completely different and you may lose data.
  - **Higher remote serial:** If the "serial" value in the destination state is higher than the state being pushed, Terraform will prevent the push. A higher serial suggests that data is in the destination state that isn't accounted for in the local state being pushed.
  - **-force** flag will be used to disable the safety check, which is not recommended.

```
#terraform state pull --> state info will be displayed as stdout
#terraform state push
```

## Terraform force-unlock
- Manually unlock the state for the defined configuration
- This will not modify your infrastructure
- This command removes the lock on the state for the current configuration
- The behavior of this lock is dependent on the backened being used.
Note: Local state files can't be unlocked by another process.
```
#terraform force-unlock <lock-id>
```

```

Plan: 1 to add, 0 to change, 0 to destroy.
aws_instance.web[0]: Creating...
aws_instance.web[0]: Still creating... [10s elapsed]
aws_instance.web[0]: Still creating... [20s elapsed]
aws_instance.web[0]: Creation complete after 24s [id=i-0f82eceff559c2d14]
╷
│ Error: Failed to save state
│
│ Error saving state: failed checking for existing remote state: RequestError: send request failed
│ caused by: Get "https://terraform-statefiles-sudheer.s3.amazonaws.com/terraform.tfstate": dial tcp: lookup
│ terraform-statefiles-sudheer.s3.amazonaws.com on 127.0.0.53:53: server misbehaving
╵
╷
│ Error: Failed to persist state to backend
│
│ The error shown above has prevented Terraform from writing the updated state to the configured backend. To allow for recovery, the state
│ has been written to the file "errored.tfstate" in the current working directory.
│
│ Running "terraform apply" again at this point will create a forked state, making it harder to recover.
│
│ To retry writing this state, use the following command:
│     terraform state push errored.tfstate
│
╵
Releasing state lock. This may take a few moments...
root@terraformworkstation:~/terraform-aws/state-locking# ls -l
total 16
-rw-r--r-- 1 root root 4022 Oct 22 02:46 errored.tfstate
-rw-r--r-- 1 root root  325 Oct 22 02:43 instance.tf
-rw-r--r-- 1 root root  467 Oct 14 03:03 provider.tf
-rw-r--r-- 1 root root  647 Oct 14 03:19 variables.tf
root@terraformworkstation:~/terraform-aws/state-locking# cat errored.tfstate
{
  "version": 4,
  "terraform_version": "1.0.7",
  "serial": 0,
  "lineage": "",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "web",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 1,
          "attributes": {
            "ami": "ami-0c2b8ca1dad447f8a",
            "arn": "arn:aws:ec2:us-east-1:017187748261:instance/i-0f82eceff559c2d14",
            "associate_public_ip_address": true,
            "availability_zone": "us-east-1a",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_core_count": 1,
            "cpu_threads_per_core": 2,
            "credit_specification": [
              {
                "cpu_credits": "unlimited"
              }
            ],
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "get_password_data": false,
            "hibernation": false,
            "host_id": null,
            "iam_instance_profile": "",
            "id": "i-0f82eceff559c2d14",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_state": "running",
            "instance_type": "t3.small",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "",
            "launch_template": [],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_put_response_hop_limit": 1,
                "http_tokens": "optional"
              }
            ],
            "monitoring": false,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_partition_number": null,
            "primary_network_interface_id": "eni-08b5eaf0f49691722",
            "private_dns": "ip-172-31-19-178.ec2.internal",
            "private_ip": "172.31.19.178",
            "public_dns": "ec2-54-160-191-97.compute-1.amazonaws.com",
            "public_ip": "54.160.191.97",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/xvda",
                "encrypted": false,
                "iops": 100,
                "kms_key_id": "",
                "tags": {},
                "throughput": 0,
                "volume_id": "vol-05746689f065a0a9f",
                "volume_size": 8,
                "volume_type": "gp2"
              }
            ],
            "secondary_private_ips": [],
            "security_groups": [
              "default"
            ],
            "source_dest_check": true,
            "subnet_id": "subnet-a3c120ef",
            "tags": {
              "Env": "Production",
              "Name": "WebApp-terraform",
              "Type": "Application",
              "Version": "v1.0"
            },
            "tags_all": {
              "Env": "Production",
              "Name": "WebApp-terraform",
              "Type": "Application",
              "Version": "v1.0"
            },
            "tenancy": "default",
            "timeouts": null,
            "user_data": null,
            "user_data_base64": null,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-7578266f"
            ]
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwidXBkYXRlIjo2MDAwMDAwMDAwMDB9LCJzY2hlbWFfdmVyc2lvbiI6IjEifQ=="
        }
      ]
    }
  ]
}
root@terraformworkstation:~/terraform-aws/state-locking#
root@terraformworkstation:~/terraform-aws/state-locking# terraform state push errored.tfstate
Acquiring state lock. This may take a few moments...
Releasing state lock. This may take a few moments...
root@terraformworkstation:~/terraform-aws/state-locking#
```

```
root@terraformworkstation:~/terraform-aws/state-locking# terraform state push terraform.tfstate
Acquiring state lock. This may take a few moments...
Failed to write state: cannot overwrite existing state with serial 1 with a different state that has the same serial
Releasing state lock. This may take a few moments...
root@terraformworkstation:~/terraform-aws/state-locking# vi terraform.tfstate
root@terraformworkstation:~/terraform-aws/state-locking# terraform state push terraform.tfstate
Acquiring state lock. This may take a few moments...
Releasing state lock. This may take a few moments...
root@terraformworkstation:~/terraform-aws/state-locking#
```

```
root@terraformworkstation:~/terraform-aws/state-locking# terraform plan
Acquiring state lock. This may take a few moments...
aws_instance.web[0]: Refreshing state... [id=i-0f82eceff559c2d14]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # aws_instance.web[0] has been changed
  ~ resource "aws_instance" "web" {
        id                                   = "i-0f82eceff559c2d14"
      ~ tags                                 = {
          - "CICD"    = "Jenkins" -> null
            # (4 unchanged elements hidden)
        }
      ~ tags_all                             = {
          - "CICD"    = "Jenkins" -> null
            # (4 unchanged elements hidden)
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
root@terraformworkstation:~/terraform-aws/state-locking# terraform apply -refresh-only
Acquiring state lock. This may take a few moments...
aws_instance.web[0]: Refreshing state... [id=i-0f82eceff559c2d14]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # aws_instance.web[0] has been changed
  ~ resource "aws_instance" "web" {
        id                                   = "i-0f82eceff559c2d14"
      ~ tags                                 = {
          - "CICD"    = "Jenkins" -> null
            # (4 unchanged elements hidden)
        }
      ~ tags_all                             = {
          - "CICD"    = "Jenkins" -> null
            # (4 unchanged elements hidden)
        }
        # (27 unchanged attributes hidden)





        # (5 unchanged blocks hidden)
    }

This is a refresh-only plan, so Terraform will not take any actions to undo these. If you were expecting these changes then you can apply
this plan to record the updated values in the Terraform state without changing any remote objects.

Would you like to update the Terraform state to reflect these detected changes?
  Terraform will write these changes to the state without modifying any real infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

Releasing state lock. This may take a few moments...

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
root@terraformworkstation:~/terraform-aws/state-locking# terraform plan
Acquiring state lock. This may take a few moments...
aws_instance.web[0]: Refreshing state... [id=i-0f82eceff559c2d14]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
Releasing state lock. This may take a few moments...
root@terraformworkstation:~/terraform-aws/state-locking#
```