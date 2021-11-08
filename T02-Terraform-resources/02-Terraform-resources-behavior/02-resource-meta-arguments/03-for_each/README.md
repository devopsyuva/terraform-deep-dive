# Terraform Resource Meta-argument for_each
- If a **resource or module block** includes a **for_each** argument whose value is a **map or a set of strings**, terraform will create **one instance for each member** of that map or set.
- Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.
- In blocks where for_each is set, an additional each object is available in expressions, so you can modify the configuration of each instance.
  - **each.key** the map key (or set member) correspoding to this instance.
  - **each.value** the map value corresponding to this instance. (if a set was provided, this is the same as each.key)
- For set of string, each.key = each.value
  - for_each = toset(["Jack","James"])
  - each.key = Jack
  - each.value = James
- For Maps, we use each.key and each.value
  - for_each = {
      dev = "my-test-resource"
  }
  - each.key = dev
  - each.value = my-test-resource
- Mudule support for for_each was added in terraform 0.13, and previous versions can only use it with resources.
- A given resource or module block can't use both count and for_each at a time.
```
variable "vpcs" {
  type = map(object({
    cidr_block = string
  }))
}

resource "aws_vpc" "example" {
  # One VPC for each element of var.vpcs
  for_each = var.vpcs

  # each.value here is a value from var.vpcs
  cidr_block = each.value.cidr_block
}

resource "aws_internet_gateway" "example" {
  # One Internet Gateway per VPC
  for_each = aws_vpc.example

  # each.value here is a full aws_vpc object
  vpc_id = each.value.id
}

output "vpc_ids" {
  value = {
    for k, v in aws_vpc.example : k => v.id
  }

  # The VPCs aren't fully functional until their
  # internet gateways are running.
  depends_on = [aws_internet_gateway.example]
}
```