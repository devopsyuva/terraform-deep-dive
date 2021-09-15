# Terraform Datasources
- Data sources allow data to be fetched or computed for use elsewhere in Terraform configuration.
- Use of data sources allows a terraform configuration to make use of information defined outside of terraform, or defined by another seprate configuration or modified by functions.
- A data source is accessed via a special kind of resource know as a data resource, decalred using a data block.
```
# This data sourec will fetch latest amazon linux AMI image
data "aws_ami" "amzlinux" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*"]
    }
    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
}
```
- data block can be called into resource block as mentioned below.
```
resource "aws_instance" "web" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t1.micro"
}
```
- Example 2: which will list all Instances IP address of "Running and Stopped" status.
```
data "aws_instances" "test" {
  instance_tags = {
    Name = "Dev"
  }

  filter {
    name   = "instance.group-id"
    values = ["sg-12345678"]
  }

  instance_state_names = ["running", "stopped"]
}

resource "aws_eip" "test" {
  count    = length(data.aws_instances.test.ids)
  instance = data.aws_instances.test.ids[count.index]
}
```

## References
- [Data Sources](https://www.terraform.io/docs/language/data-sources/index.html)
- [Query Terraform Data Source](https://learn.hashicorp.com/tutorials/terraform/data-sources?in=terraformconfiguration-language)
- [AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html)