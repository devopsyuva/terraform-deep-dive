# Terragrunt Configuration File
- Terragrunt configuration ends with ".hcl" extension
- It uses same as HCL (Hashicorp Configuration Launguage) syntax uses in Terraform, so it is easy to understand
- Terragrunt supports "JSON-serialized HCL" as well, where we can use "terragrunt.hcl.json" as extension
- As mentioned below, Terragrunt will identify the path of configuration files bases on rules mentioned below:
  - command-line argument
  - environment variable
  - current working directory
  - JSON files in current working directory

## Configuration execution order
- include block
- locals block
- iam_role, iam_assume_role_duration, and iam_assume_role_session_time
- dependencies block
- dependency block
- followed by rest of the blocks

## Formatting Configuration files
- Terragrunt configuration files can be rewritten to canonical format using "hclfmt"
- Command #terragrunt hclfmt will rewite the file. If not needed, just pass "--terragrunt-check" to the command
- It is similar to what we do in Terraform to format configuration files #terraform fmt
- Terragrunt picks the files in working directory, as well as other configuration files in recursive order in working directory
- command to format configuration files to canonical format #terragrunt hclfmt

## tree view of Terragrunt configuration files in recursive order for formatting
```
```