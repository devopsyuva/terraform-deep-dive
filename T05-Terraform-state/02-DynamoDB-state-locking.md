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