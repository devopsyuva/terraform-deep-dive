module "vnet" {
  source = "./modules/vnet"

  resource_group_name = "sudheerdevsecops"
  vnet_cidr           = ["10.200.0.0/16"]
  vnet_name           = "visualpathdemo"
  region              = "West US"
  subnet01            = ["10.200.0.0/24"]
  subnet02            = ["10.200.1.0/24"]
}