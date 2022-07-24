data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = ["vpc-09a642518232ca04b"]
  }
}

resource "aws_ec2_tag" "vpc_tag" {
  for_each    = toset(data.aws_subnets.example.ids)
  resource_id = each.value
  key         = "Name"
  value       = "default-subnets"
}

output "subnet_list" {
  value = data.aws_subnets.example.ids
}

data "aws_network_interfaces" "aws_nic" {
  filter {
    name   = "vpc-id"
    values = ["vpc-09a642518232ca04b"]
  }
}

resource "aws_ec2_tag" "vpc_tag" {
  for_each    = toset(data.aws_network_interfaces.aws_nic.ids)
  resource_id = each.value
  key         = "Name"
  value       = "default-subnets"
}

output "example" {
  value = data.aws_network_interfaces.aws_nic.ids
}
