# Terraform Datasources
- Data sources allow data to be fetched or cumputed for use elsewhere in Terraform configuration.
- Use of data sources allows a terraform configuration to make use of information defined outside of terraform, or defined by another seprate configuration.
- A data source is accessed via a special kind of resource know as a data resource, decalred using a data block.
```
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

## References
- [Data Sources](https://www.terraform.io/docs/language/data-sources/index.html)