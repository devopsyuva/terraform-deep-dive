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
}
```

## Terraform Provider block
```
provider "aws" {
    region = "us-east-1"
    profile = "default"
}
```

## Terraform Resource block
```
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"

  tags = {
    Name = "WebApp-terraform"
  }
}
```

## Terraform Variable block
### Terraform Input Variables block
```
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "AppServerInstance"
}

variable "instance_ami" {
  description = "name/id of the AMI to use for EC2"
  type = string
  default = "ami-0c2b8ca1dad447f8a"
}

variable "instance_type" {
  description = "instance type/flavor to use specific resource"
  type = string
  default = "t3.micro"
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
}
```

### Terraform Local Values block
- Local values can be helpful to avoid repeating the same values or expressions multiple times in a configuration, but if overused they can also make a configuration hard to read by future maintainers by hiding the actual values used.
- Use local values only in moderation, in situations where a single value or result is used in many places and that value is likely to be changed in future.
```
locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
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