# Terraform Fundamental blocks

## Terraform Settings block
```
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
    required_version = ">= 0.14.9"
    experiments = [example]
    
    # S3 bucket for storing state file in remote backend
    backend "s3" {
        bucket = "terraform-statefiles-sudheer"
        key = "Prod/terraform.tfstate"
        region = "us-east-1"

        # State Locking using DynamoDB Table
        dynamodb_table = "terraform-dev-state-table"
    }

    provider_meta "aws" {
      username = "sudheer_demo"
    }
}
```

## Terraform Provider block
```
provider "aws" {
    region                    = "us-east-1"
    alias                     = "useast"
    profile                   = "default"
    #secret_key               = "SD43445NK4N4JTNME4"
    #access_key               = "J5H54NLJ3422KNMK6NK5NLK76NK"
    #shared_config_files      = ["/home/sudheer/.aws/conf"]
    #shared_credentials_files = ["/home/sudheer/.aws/creds"]
    #assume_role {
    #  role_arn     = "arn:aws:iam::11233889988:role/terraform_admin"
    #  session_name = "SESSION_NAME
    #  external_id  = "EXTERNAL_ID"
    #}
}
```

## Terraform Resource block
Syntax
```
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```
```
Example:
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"

  lifecycle {
    precondition {
      condition     = data.aws_ami.ami_list.architecture == "x86_64"
      error_message = "We need to provide AMI with x86_64 arch only"
    }
  }

  tags = {
    Name = "WebApp-terraform"
  }

  timeouts {
    create = "60m"
    delete = "2h"
  }
}
```

## Terraform Variable block
### Terraform Input Variables block
```
variable "common_tags" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
}

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "az_names" {
  description = "provide AZ names to launch EC2 instance"
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
```

### Terraform Output Values block
- Optional arguments:
  - **description:** you can briefly describe the purpose of each value using the optional description argument.
  - **sensitive:** To suppress values in CLI output
  - **depends_on:** The depends_on argument should be used only as a last resort.
```
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
  sensitive   = true
  depends_on  = [
      aws_vpc.vpc
  ]
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip

  # The EC2 instance must have an encrypted root volume.
  precondition {
    condition     = data.aws_ebs_volume.example.encrypted
    error_message = "The server's root volume is not encrypted."
  }
}
```

### Terraform Local Values block
- Local values can be helpful to avoid repeating the same values or expressions multiple times in a configuration, but if overused they can also make a configuration hard to read by future maintainers by hiding the actual values used.
- Use local values only in moderation, in situations where a single value or result is used in many places and that value is likely to be changed in future.
```
locals {
  name_suffix = "${var.resource_tags["project"]}-${var.resource_tags["environment"]}"
}

locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = var.service_name
    Owner   = var.owner
  }
}
```

## Terraform calling/referencing block
### Data Sources block
```
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
```
### Modules block
```
module "consul" {
  source  = "hashicorp/consul/aws"
  version = "0.0.5"

  servers = 3
}
```

## Terraform Credentials Block
- 
```
credentials "app.terraform.io" {
    # valid user API token:
    token = "xxxxxx.atlasv1.zzzzzzzzzzzzz"
}
module "instance_vpc" {
  source  = "app.terraform.io/visualpath-demo/instance_vpc/aws"
  version = "1.0.1"
}
```

#### References:
- [credentials block](https://www.terraform.io/docs/cli/config/config-file.html)