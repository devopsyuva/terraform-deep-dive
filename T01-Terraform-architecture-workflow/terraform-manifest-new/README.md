# Terraform new block called terraform settings
- sample file which is having terraform and provider block.
  - Terraform block contains terraform settings, which also has required providers it will use to provision your infrastucture.
  - Each Terraform module must declare which providers it requires under required_provider block, so that Terraform can install and use them.
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=> 3.5"
    }
  }
}

#we can declare multple conditions to version as mentioned below
= (or no operator): Allows only one exact version number. Cannot be combined with other conditions.

!=: Excludes an exact version number.

>, >=, <, <=: Comparisons against a specified version, allowing versions for which the comparison is true. "Greater-than" requests newer versions, and "less-than" requests older versions.

~>: Allows only the rightmost version component to increment. For example, to allow new patch releases within a specific minor release, use the full version number: ~> 1.0.4 will allow installation of 1.0.5 and 1.0.10 but not 1.1.0. This is usually called the pessimistic constraint operator.
```
  - Provider block contains configuration specific to provider like AWS, Azure etc.,
  - A provider is a plugin that terraform uses to create and manage your resources.
  - Multi-provider configuration:
    - Inorder to define multiple configurations for a same provider.
    - If we want one resource to be created in Region ```us-east-1``` and another resource in Region ```us-east-2```.
    ```
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 3.0, <4.0"
        }
      required_version = ">= 0.14.9"
      }
    }
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
```
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances# cat provider.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0, <4.0"
    }
  required_version = ">= 0.14.9"
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
}
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances#
```

- check below file location for profile information "default" section added in credentials file while executing ```aws configure``` command to store secret and access key.
```
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances# cat ~/.aws/credentials
[default]
aws_secret_access_key = xxxxxxx
aws_access_key_id = xxxxxxxx
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances# cat ~/.aws/config
[default]
region = us-east-1
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances#
```

- Lets create a resource block in separate file ```main.tf```, which will create a resource as specified in configuration file.
```
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"

  tags = {
    Name = "WebApp-terraform"
  }
}

How to get AMI ID?
aws console --> EC2 Dashboard --> Instances --> Launch instances --> choose an AMI --> get the latest AMI ID from there as per OS
How to check instance_type?
aws console --> EC2 Dashboard --> Instance Types --> Free trier (t2.micro)
```

- Now run ```terraform plan``` to see if the resources which we are trying to create has no issue and as expected before we actaully create it.
```
terraform plan
```

- Now sample output after executing ```terraform init``` with new terraform settings block
```
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances# terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 3.0, < 4.0.0"...
- Installing hashicorp/aws v3.53.0...
- Installed hashicorp/aws v3.53.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances# tree -a
.
├── main.tf
├── outputs.tf
├── provider.tf
├── .terraform
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── aws
│                   └── 3.53.0
│                       └── linux_amd64
│                           └── terraform-provider-aws_v3.53.0_x5
├── .terraform.lock.hcl
└── variables.tf

7 directories, 6 files
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances#
```

- validate the resource created EC2 by login to ```AWS Console```.
- Now destroy the resource created on the target provider by executing ```terraform destroy -auto-approve```.

## References:
- [Configuration language](https://www.terraform.io/docs/language/index.html)
- [Configuration Syntax](https://www.terraform.io/docs/language/syntax/configuration.html)
- [Providers](https://www.terraform.io/docs/language/providers/index.html)
- [Registry](https://registry.terraform.io/)
- [version constraints](https://www.terraform.io/docs/language/expressions/version-constraints.html)
- [Requirements](https://www.terraform.io/docs/language/providers/requirements.html)