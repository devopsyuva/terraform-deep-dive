# Input Variable block
variable "region_code" {
  description = "Provide the Region name on which to manage the resources"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "Provide VNet name to create Virtual Network"
  type        = string
  default     = "demovirtualnetwork"
}

variable "vnet_cidr" {
  description = "Provide CIDR value with base 16 from Class-A"
  type        = list(string)
  default     = ["10.100.0.0/16"]
}

variable "nic_name" {
  description = "Provide name for the NIC to be used by VM"
  type        = string
  default     = "publicinstance-nic"
}

variable "rg_name" {
  description = "Provide name of the Resource group under which resources will be managed"
  type        = string
  default     = "virtualmachinedemo"
}

variable "subnet_one" {
  type    = string
  default = "subnet01"
}

variable "subnet_two" {
  type    = string
  default = "subnet02"
}

variable "public_ip_name" {
  type    = string
  default = "vmpublicip"
}

variable "count_number" {
  description = "Provide count to create number of resources"
  type = number
  default = 2
}

# Local block values
locals {
  common_tags = {
    "Environment" = "Development"
    "Type"        = "3-tier Application"
  }
}