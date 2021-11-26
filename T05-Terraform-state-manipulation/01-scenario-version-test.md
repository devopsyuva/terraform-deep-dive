# Terraform Remote State Storage

## Pre-requisite
- Login to AWS Console with your root credentails or IAM user.
- Navigate to on top middle serach bar for "s3" service.
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

## Terraform statefile migration
```
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# tree -a
.
├── instance.tf
├── provider.tf
├── .terraform
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── aws
│                   └── 3.67.0
│                       └── linux_amd64
│                           └── terraform-provider-aws_v3.67.0_x5
├── .terraform.lock.hcl
├── terraform.tfstate
└── variables.tf

7 directories, 6 files
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# cat provider.tf
terraform {
  required_version = ">= 1.0.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # S3 bucket for storing state file in remote backend
  backend "s3" {
    bucket         = "terraform-statefiles-sudheer"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-prod-statefile"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"
}
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery#
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# terraform init

Initializing the backend...
Acquiring state lock. This may take a few moments...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes

Releasing state lock. This may take a few moments...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v3.67.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# cat terraform.tfstate
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery# cat terraform.tfstate.backup
{
  "version": 4,
...
...
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwidXBkYXRlIjo2MDAwMDAwMDAwMDB9LCJzY2hlbWFfdmVyc2lvbiI6IjEifQ=="
        }
      ]
    }
  ]
}
root@terraformworkstationdemo:~/terraform-aws/state-manipulation/disaster-recovery#
```