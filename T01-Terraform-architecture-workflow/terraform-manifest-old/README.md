# Older format in terraform 0.12 and earlier
1) Sample output after executing ```terraform init```
```
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins# ls -al
total 12
drwxr-xr-x 2 root root 4096 Aug  8 08:55 .
drwxr-xr-x 7 root root 4096 Aug  8 08:52 ..
-rw-r--r-- 1 root root  118 Aug  8 08:55 provider.tf
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins# cat provider.tf
provider "aws" {
  version = "~> 3.0" // Terraform aws plugin version
  region  = "us-east-1"
  profile = "default"
}
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins# terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 3.0"...
- Installing hashicorp/aws v3.53.0...

- Installed hashicorp/aws v3.53.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

╷
│ Warning: Version constraints inside provider configuration blocks are deprecated
│
│   on provider.tf line 2, in provider "aws":
│    2:   version = "~> 3.0" // Terraform aws plugin version
│
│ Terraform 0.13 and earlier allowed provider version constraints inside the provider configuration block, but that
│ is now deprecated and will be removed in a future version of Terraform. To silence this warning, move the
│ provider version constraint into the required_providers block.
╵

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins#
```

2) After successful execution, check the terraform aws provider plugin location under ```.terraform``` folder.
```
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins# tree -a
.
├── provider.tf
├── .terraform
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── aws
│                   └── 3.53.0
│                       └── linux_amd64
│                           └── terraform-provider-aws_v3.53.0_x5
└── .terraform.lock.hcl

7 directories, 3 files
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins#
```

3) Another file called ```.terraform.lock.hcl``` created, which is a dependency lock file.
- This file is created or updated each time when we run command ```terraform init```.
- It is maintained by terraform, rather than being updated manually.
- The new lock file entry records several pieces of information:
  - **version:** the exact version that Terraform selected based on the version constraints in the configuration.
  - **constraints:** all of the version constraints that Terraform considered when making this selection. (Terraform doesn't actually use this information to make installation decisions, but includes it to help explain to human readers how the previous decision was made.)
  - **hashes:** a number of checksums that are all considered to be valid for packages implementing the selected version of this provider on different platforms. The meaning of these hashes is explained more under New provider package checksums below.
```
Sample content of ".terraform.lock.hcl":
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins# cat .terraform.lock.hcl
# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/hashicorp/aws" {
  version     = "3.53.0"
  constraints = "~> 3.0"
  hashes = [
    "h1:oRCCzfwGCDNyuhIJ8kCg0N7h4W2WESm37o2GIt0ETpQ=",
    "zh:35a77c79170b0cf3fb7eb835f3ce0b715aeeceda0a259e96e49fed5a30cf6646",
    "zh:519d5470a932b1ec9a0fe08876c5e0f0f84f8e506b652c051e4ab708be081e89",
    "zh:58cfa5b454602d57c47acd15c2ad166a012574742cdbcf950787ce79b6510218",
    "zh:5fc3c0162335a730701c0175809250233f45f1021da8fa52c73635e4c08372d8",
    "zh:6790f9d6261eb4bd5cdd7cd9125f103befce2ba127f9ba46eef83585b86e1d11",
    "zh:76e1776c3bf9568d520f78419ec143c081f653b8df4fb22577a8c4a35d3315f9",
    "zh:ca8ed88d0385e45c35223ace59b1bf77d81cd2154d5416e63a3dddaf0def30e6",
    "zh:d002562c4a89a9f1f6cd8d854fad3c66839626fc260e5dde5267f6d34dbd97a4",
    "zh:da5e47fb769e90a2f16c90fd0ba95d62da3d76eb006823664a5c6e96188731b0",
    "zh:dfe7f33ec252ea550e090975a5f10940c27302bebb5559957957937b069646ea",
    "zh:fa91574605ddce726e8a4e421297009a9dabe023106e139ac46da49c8285f2fe",
  ]
}
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins#
```

4) Below command shows when new version of terraform version was release and provider information we are using.
```
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances# terraform --version
Terraform v1.0.3
on linux_amd64
+ provider registry.terraform.io/hashicorp/aws v3.52.0

Your version of Terraform is out of date! The latest version
is 1.0.4. You can update by downloading from https://www.terraform.io/downloads.html
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-instances#
```

5) if we need to upgrade the provider version to the latest release
```
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins# terraform init --upgrade

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 3.0"...
- Using previously-installed hashicorp/aws v3.53.0

╷
│ Warning: Version constraints inside provider configuration blocks are deprecated
│
│   on provider.tf line 2, in provider "aws":
│    2:   version = "~> 3.0" // Terraform aws plugin version
│
│ Terraform 0.13 and earlier allowed provider version constraints inside the provider configuration block, but that
│ is now deprecated and will be removed in a future version of Terraform. To silence this warning, move the
│ provider version constraint into the required_providers block.
╵

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
root@ubuntuserverdocker:~/aws-terraform/terraform-aws-ins#
```
# References:
- [Version Constraint](https://www.terraform.io/docs/language/expressions/version-constraints.html)
- [dependency-lock](https://www.terraform.io/docs/language/dependency-lock.html)