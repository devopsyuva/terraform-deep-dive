# When using this terragrunt config, terragrunt will generate the file "provider.tf"
# with the aws provider block before calling to terraform.
# Note that this will overwrite the `provider.tf` file if it already exists.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region      = "us-east-1"
  profile     = "eks-cluster"
  access_key  = "account-access-key"
  secret-key  = "account-secret-key"
  #shared_config_files      = ["/Users/sudheer/.aws/conf"]
  #shared_credentials_files = ["/Users/sudheer/.aws/creds"]
}
EOF
}