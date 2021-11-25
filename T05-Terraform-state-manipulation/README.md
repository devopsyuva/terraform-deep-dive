# Terraform State
- Terraform State Storage
- Terraform State Locking

**Terraform state backends works on three principles like State Storage(Backend Storage), State Locking(Locking state files stored in shared location) and Operations/Runs --> Create, Read, Update, and destroy resources on respective provider.**

- [Terraform Local State Storage](../src/images/terraform-state-remote.png)
- [Terraform Remote State Storage](../src/images/terraform-state-remote-remote.png)

## Terraform backend
- Backend are responsible for storing state and providing API for state locking.
  - AWS S3 Bucket for terraform state storage.
  - AWS DynamoDB for terraform state locking.
- Differences between Local state file and Remote state file.
- **Local State:** Multiple team members cannot update the infrastructure as they don't have access to state File. For which we need to store the state file in a share location.
- **Remote State:** If two teams are running Terraform at same time, you may run into **race conditions** as multiple Terraform proccess make concurrent updates to the state files, leading to conflicts, data loss, and state file corruption.
- To overcome above condition, state locking was added with the help of DynamoDB table.
- [Terraform State Locking](../src/images/terraform-state-remote-locking.png)
- **Note:** All backends doesn't support State locking, AWS S3 supports state locking.
- State locking happends automatically on all operations that could write state.
- If state locking fails, Terraform will not continue.
- You can disable state locking for most commands with the **-lock** flag but it not receommended.
- If acquiring the lock file takes long time then expected, Terraform will output a status message.
- If terraform doesn't output a message, state locking is still occuring if your backend supports it.
- Terraform has a force-unlock command to manually unlock the state if unlocking failed.
```
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
    bucket = "terraform-statefiles"
    key = "dev/terraform.tfstate"
    region = "us-east-1"

    # State Locking
    dynamodb_table = "terraform-dev-state-table"
  }
}

provider "aws" {
    region = "us-east-1"
    profile = "default"
}
```
- **Terraform Cloud and Terraform Enterprise** always use their own state storage when performaing terraform runs, so they ignore any backend block in the configuration.
- For **Terraform Cloud** users it is always recommended to use backend block in Terraform configuration for commands like **terraform taint** which can be executed only using Terraform CLI.

## Terraform Backend Types
- Enhanced and Standard Backends
- **Enhanced Backends:** can perform two tasks like store state and perform operations. There are two enhanced backends: **local and remote.**
  - Examples: Terraform Cloud and Terraform Enterprise
- **Standard Backends:** they only store state, and rely on the local backend for performing operations.
  - Examples: AWS S3, Azure RM, Consul, ETCD, and etc.,

## Terraform commands for state perspective
- terraform show
- terraform refresh
- terraform plan
- terraform state
- terraform force-unlock
- terraform taint
- terraform untaint
- terraform apply target

### References
- [Terraform State Manipulation](https://www.terraform.io/docs/cli/state/index.html)
- [AWS state Locking and Store](https://www.terraform.io/docs/language/settings/backends/s3.html)
- [Azure State Locking and Store](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)