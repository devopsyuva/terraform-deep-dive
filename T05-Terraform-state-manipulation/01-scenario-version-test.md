# Terraform Remote State Storage

## Pre-requisite
- Login to AWS Console with your root credentails or IAM user.
- Navigate to AWS S3 on top middle serach bar.
- Go to Buckets --> Create bucket
- General configuration
  - Bucket name: terraform-statefiles-sudheer (name should be unique across AWS S3)
  - AWS Region: US East (N. Virginia) us-east-1
- Bucket Versioning
  - Bucket Versioning: Enable
- Tags(Optional)
  - Name: Terraform
- Default Encryption: Leave as default settings
- Advanced Settings: Default options, no need to modify

- Now go inside the Bucket "terraform-statefiles-sudheer"
  - Objects --> Create folder
  - Folder name: Prod

## Initial Execution with above default settings remote store S3 Bucket
- Lets execute below commands, with reference of "terraform-manifest" folder to store state file in remote like S3 bucket.
```
- terraform init
- terraform validate
- terraform fmt
- terraform plan --> check if terraform.tfstate file was created either local or remote(s3)
- terraform apply -auto-approve --> Now check on local(which should not create) and remote s3 backet "terraform-statefile-sudheer" to check terraform.tfstate file create on remote backend storage
```

## versioning test
```
update instance_type to some other value to check the versioning of s3 bucket state file.
terraform plan
terraform apply -auto-approve --> check in s3 bucket if two versions are available under bucket "terraform-statefiles-sudheer" --> go to "Prod" --> click on file "terraform.tfstate" --> Versions tab
```

### Note:
- Disable DynamoDB section for remote store for this initial demo