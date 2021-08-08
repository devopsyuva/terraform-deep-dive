# Terraform new block called terraform settings
- sample file which is having terraform and provider block.
```
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances# cat provider.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0, <4.0"
    }
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