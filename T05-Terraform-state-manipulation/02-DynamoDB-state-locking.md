# Terraform State locking using AWS DynamoDB Table

## Pre-requisite
- Create DynamoDB(NoSQL) Table
  - AWS Console --> DynamoDB --> Create table
  - Table details
    - Table name: terraform-prod-statefile
    - Partition key(Primary Key): LockID (string) # Do not add this as string StatelockID (string)
    - Settings: Default settings
  - click on Create table

## Update provider.tf file with dynamodb_table parameter
```
#Open provider.tf file and add entry in backend block
dynamodb_table = "terraform-prod-statefile"
```

## Execute below command to check if locking was enabled
```
- terraform init
- terraform validate (Optional)
- terraform fmt (Optional)
- terraform plan --> check if it displays message on terminal "Acquring state lock" and "Releasing state lock".
# During this terraform state locking happened, none of them can execute commands which changes the state file.
- terraform apply -auto-approve --> Here also we can see the state locking and release will happen during this period
```

```
root@terraformworkstation:~/terraform-aws/state-locking# terraform init

Initializing the backend...
╷
│ Error: Backend configuration changed
│
│ A change in the backend configuration has been detected, which may require migrating existing state.
│
│ If you wish to attempt automatic migration of the state, use "terraform init -migrate-state".
│ If you wish to store the current configuration with no changes to the state, use "terraform init -reconfigure".
╵
```

- Below error shows that, one process has already initiated to apply the changes.
```
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform plan
Acquiring state lock. This may take a few moments...
╷
│ Error: Error acquiring the state lock
│
│ Error message: ConditionalCheckFailedException: The conditional request failed
│ Lock Info:
│   ID:        768eef51-a477-650f-d106-79bddffcfc19
│   Path:      terraform-statefiles-sudheer/terraform.tfstate
│   Operation: OperationTypeApply
│   Who:       root@terraformworkstationdemo
│   Version:   1.0.9
│   Created:   2021-11-22 15:22:34.402430024 +0000 UTC
│   Info:
│
│
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
╵
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage#
```
```
root@terraformworkstation:~/terraform-aws/state-locking# terraform plan
Acquiring state lock. This may take a few moments...
╷
│ Error: Error acquiring the state lock
│
│ Error message: 2 errors occurred:
│       * ValidationException: One or more parameter values were invalid: Missing the key StatelockID in the item
│       status code: 400, request id: G2RD1OLSK8HCO6H7H262J7L0T7VV4KQNSO5AEMVJF66Q9ASUAAJG
│       * ValidationException: The provided key element does not match the schema
│       status code: 400, request id: T4MI3T96BMSHU6JANIN79FTJDFVV4KQNSO5AEMVJF66Q9ASUAAJG
│
│
│
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
╵
```
- Common issue, if we cancel the task either #terraform plan/apply when state locking is acquired. How to resolve it?
```
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform plan
Acquiring state lock. This may take a few moments...
╷
│ Error: Error acquiring the state lock
│
│ Error message: ConditionalCheckFailedException: The conditional request failed
│ Lock Info:
│   ID:        0febad49-d6ec-4ce5-a84a-ff0b54d0712a
│   Path:      terraform-statefiles-sudheer/terraform.tfstate
│   Operation: OperationTypeApply
│   Who:       root@terraformworkstationdemo
│   Version:   1.0.9
│   Created:   2021-11-23 15:35:01.258366319 +0000 UTC
│   Info:
│
│
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
╵

root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform force-unlock 0febad49-d6ec-4ce5-a84a-ff0b54d0712a
Do you really want to force-unlock?
  Terraform will remove the lock on the remote state.
  This will allow local Terraform commands to modify this state, even though it
  may be still be in use. Only 'yes' will be accepted to confirm.

  Enter a value: yes

Terraform state has been successfully unlocked!

The state has been unlocked, and Terraform commands should now be able to
obtain a new lock on the remote state.

root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage# terraform plan
Acquiring state lock. This may take a few moments...

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
...
...
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
Releasing state lock. This may take a few moments...
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/remote-storage#
```