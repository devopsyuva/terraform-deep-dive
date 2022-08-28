locals {
  aws_region  = "us-east-1"
}

inputs = {
    region = local.aws_region
    name   = "${local.aws_region}-bucket"
}