# When applying this terragrunt config in an `run-all` command, make sure the modules at "../vpc"
# and "../rds/mysql" are handled first.
dependencies {
  paths = ["../vpc", "../rds/mysql"]
}