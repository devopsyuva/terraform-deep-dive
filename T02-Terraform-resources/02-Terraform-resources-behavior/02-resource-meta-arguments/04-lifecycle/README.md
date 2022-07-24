# Terraform Resource Meta-arguments lifecycle
- lifecycle is a nested block that can appear within a resource block.
- The lifecycle block and its contents are meta-arguments, available for all resource blocks regardless of type.
- There are three ways to change the behavior of the resources as mentioned below:
  - create_before_destroy
  - prevent_destroy
  - ignore_changes
- **create_before_destroy**
```
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  key_name = "terraform-demo"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1c"
  user_data = file("nginx-install.sh")

  tags = {
    "Name" = "WebApp-terraform"
  }
  lifecycle {
      create_before_destroy = true
  }
}
Note:
In above block, default bahaviour is to destroy the instance in az "us-east-1a" and create it in az "us-east-1c".
But now, after adding lifecycle to create_before_destroy. It will create a resource in az "us-east-1c" first and then it will destroy in az "us-east-1a".
```
- **prevent_destroy**
```
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  key_name = "terraform-demo"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1c"

  tags = {
    "Name" = "WebApp-terraform"
  }
  lifecycle {
      prevent_destroy = true
  }
}
Note:
It will not be delete resource, even after executing #terraform destroy command.
To avoid accidental deletion of resource we can add above lifecycle.

Output for Above lifecycle Meta-argument:
root@terraformworkstation:~/terraform-aws/day6# terraform destroy
aws_instance.web: Refreshing state... [id=i-01666d56f858ecf31]
╷
│ Error: Instance cannot be destroyed
│
│   on instances.tf line 1:
│    1: resource "aws_instance" "web" {
│
│ Resource aws_instance.web has lifecycle.prevent_destroy set, but the plan calls for this resource to be destroyed. To avoid this error and continue with the plan, either
│ disable lifecycle.prevent_destroy or reduce the scope of the plan using the -target flag.
╵
root@terraformworkstation:~/terraform-aws/day6#
```
- **ignore_changes**
```
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  key_name = "terraform-demo"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1c"

  tags = {
    "Name" = "WebApp-terraform"
  }
  lifecycle {
      ignore_changes = [
          tags,
      ]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1c"

  tags = {
    "Name" = "WebApp-terraform"
  }
  lifecycle {
    ignore_changes = [
      ami,
      tags,
    ]
  }
}
# Terraform 0.12 and later syntax
resource "aws_vpc" "example" {
  # ... other configuration ...

  tags = {
    Name  = "MyVPC"
    Owner = "Operations"
  }

  lifecycle {
    ignore_changes = [tags.Name]
  }
}
Note:
It will not update the changes specified in the list of ignore_changes.
This will be useful for unwanted changes.
If some manual changes are added and that should not get effected by terraform to recreate/destroy, we can use ignore.

root@terraformworkstation:~/terraform-aws/day6# terraform plan
aws_instance.web: Refreshing state... [id=i-01666d56f858ecf31]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```