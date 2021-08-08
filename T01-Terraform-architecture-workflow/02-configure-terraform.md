# Terraform Configuration Syntax
- Terraform configuration files are plain text files which ends with **filename.tf** as extension.
- **HCL(Hashicorp Language)**
- Terraform uses resource block to create Infrastructure (For AWS: EC2, VPC, S3 etc.,) services on respective provider like AWS, Azure, GCP etc., mentioned in provider block.
```
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}

<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```
- Terraform relies on plugins called "providers" to interact with remote systems.
- Terraform configurations must declare which providers they require, so that Terraform can install and use them.
- Provider configurations belong in the root module of a Terraform configuration. (Child modules receive their provider configurations from the root module)
```
#provider.tf
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
```

## terraform settings
- The special terraform configuration block type is used to configure some behaviors of Terraform itself, such as requiring a minimum Terraform version to apply your configuration.
```
terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}
```
Note:
source  - the global source address for the provider you intend to use, such as hashicorp/aws
and version - a version constraint specifying which subset of available provider versions the module is compatible with.

- **multi-providers:** To create multiple configurations for a given provider, include multiple provider blocks with the same provider name. For each additional non-default configuration, use the alias meta-argument to provide an extra name segment.
```
# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.
provider "aws" {
  region = "us-east-1"
}

# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
```
- From above example, we could see that default provider resource region will be "us-east1" and for ther resources it uses "us-east-2"

- **terraform backend:** It is used to store the state files in the remote location.
```
terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```

## References
- [Backend Configuration](https://www.terraform.io/docs/language/settings/backends/index.html)
- [Backend s3](https://www.terraform.io/docs/language/settings/backends/s3.html)