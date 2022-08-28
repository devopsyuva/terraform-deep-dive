terraform {
    # Deply version @v0.1.0 on target provider
    source = "git::git@github.com:sudheerdemo/modules.git//app?ref=v0.1.0"

    extra_arguments "custom_vars" {
        commands = [
            "fmt",
            "validate",
            "apply",
            "plan",
            "import",
            "push",
            "refresh"
        ]
    }

    extra_arguments "retry_lock" {
    commands = [
      "init",
      "apply",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint"
    ]

    arguments = [
      "-lock-timeout=20m"
    ]

    # with the get_terragrunt_dir() fuctions, we can use relative paths!!
    arguments = [
        "-var-file=${get_terragrunt_dir()}/../common.tfvars",
        "-var-file=stage-env.tfvars"
    ]

    env_vars = {
        TF_VAR_var_from_environment = "value"
    }

    before_hook "before_hook1" {
      commands = ["apply", "plan"]
      execute  = ["echo", "Running Terraform"]
    }

    before_hook "before_hook2" {
      commands = ["apply", "plan"]
      execute  = ["echo", "Will run terraform commands"]
    }

    after_hook "after_hook1" {
      commands     = ["apply", "plan"]
      execute      = ["echo", "Finished running Terraform"]
      run_on_error = true
    }

    # It will be executed before/after hooks
    error_hook "import_resource" {
      commands = ["apply"]
      execute  = ["echo", "Error hook commands"]
      on_errors = [
        ".*",
      ]
    }
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

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::0123456789:role/terragrunt"
  }
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "aws_s3_backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "dev-env-statefiles"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dev-env-statelock"
  }
}

include "root" {
    path = find_in_parent_folders()
}

dependency "vpc" {
    config_path = "../vpc"
}

locals {
    source_base_url = "github.com/sudheerdemo/modules.git//app"
}

inputs = {
    instance_count = 3
    instance_type  = "t2.large"
    vpc_id         = dependency.vpc.outputs.vpc_id
}