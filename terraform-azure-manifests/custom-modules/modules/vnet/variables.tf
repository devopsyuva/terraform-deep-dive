variable "region" {
  description = "Provide location under which resources should be managed"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Provide name of the resource group to manage resources of VNet"
  type        = string
  default     = "virtualnetworkdemo"
}

variable "vnet_name" {
  description = "Provide name for Virtual Network"
  type        = string
  default     = "VNetDemo"
}

variable "vnet_cidr" {
  description = "Provide CIDR for VNet"
  type        = list(string)
  default     = ["10.100.0.0/16"]
}

variable "subnet01" {
  type = list(string)
  default = [ "10.100.0.0/24" ]
}

variable "subnet02" {
  type = list(string)
  default = [ "10.100.1.0/24" ]
}

locals {
  common_tags = {
    "Environment" = "Production"
    "Type"        = "Webserver Network"
  }
}