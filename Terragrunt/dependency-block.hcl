# Run `terragrunt output` on the module at the relative path `../vpc` and expose them under the
#attribute `dependency.vpc.outputs`
dependency "vpc" {
  config_path = "../vpc"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs
  # available (e.g the module hasn't been applied yet)
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "vpc-f34fgy65ew"
  }
}

# Another dependency, available under the attribute `dependency.rds.outputs`
dependency "mysql_db" {
  config_path = "../rds/mysql"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  db_url = dependency.mysql_db.outputs.db_url
}