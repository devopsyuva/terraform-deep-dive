terraform {
    # Deply version @v0.1.0 on target provider
    source = "git::git@github.com:sudheerdemo/modules.git//app?ref=v0.1.0"
}

generate "backend" {
    path = "aws_s3_backend.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
    backend "s3" {
        bucket         = "dev-env-statefiles"
        key            = "${path_relatove_to_include()}/terraform.tfstate"
        region         = "us-east-1"
        encrypt        = true
        dynamodb_table = "dev-env-statefilelock"
    }
}
EOF
}

inputs = {
    inst_count = 3
    inst_type  = "t2.large"
    az_name    = "us-east-1a"
    vpc_id     = dependency.vpc.outputs.vpc_id
}