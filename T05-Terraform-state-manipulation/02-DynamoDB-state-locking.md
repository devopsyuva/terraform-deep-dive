# Terraform State locking using AWS DynamoDB Table

## Pre-requisite
- Create DynamoDB(NoSQL) Table
  - AWS Console --> DynamoDB --> Create table
  - Table details
    - Table name: terraform-prod-statefile
    - Partition key(Primary Key): StatelockID (string)
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