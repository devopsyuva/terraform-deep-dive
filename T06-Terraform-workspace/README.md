# Terraform Workspace for CLI not cloud
- Terraform starts with a single workspace name "default" and this can't deleted for ever and this is a default workspace.
- Each Terraform configuration has an associated backend that defines how operations are executed and where persistent data such as the Terraform state are stored.
- Every terraform workspace will have its own tfstate file.
- The persistent data stored in the backend belongs to a workspace. Initially the backend has only one workspace, called "default", and thus there is only one Terraform state associated with that configuration.
- Certain backends support multiple named workspaces, allowing multiple states to be associated with a single configuration.
- Following backends only support multiple workspaces:
  - S3
  - AzureRM
  - Consul
  - Kubernetes
  - Postgres
  - Local
  - GCS
  - COS
  - Manta
  - Remote
- Terraform starts with a single workspace named "default". This workspace is special because it is the default and also because it cannot be deleted. If you've never explicitly used workspaces, then you've only ever worked on the "default" workspace.
```
# How to create a new workspace?
- terraform workspace new test-demo
Created and switched to workspace "test-demo"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.

# How to call workspace in resource block?
resource "aws_instance" "example" {
  count = "${terraform.workspace == "default" ? 5 : 1}"

  # ... other arguments
}

or

resource "aws_instance" "example" {
  tags = {
    Name = "web - ${terraform.workspace}"
  }

  # ... other arguments
}
```

## Usecase of terraform workspace creation
- A common use for multiple workspaces is to create a parallel, distinct copy of a set of infrastructure in order to test a set of changes before modifying the main production infrastructure. For example, a developer working on a complex set of infrastructure changes might create a new temporary workspace in order to freely experiment with changes without affecting the default workspace.

## Workspace commands
```
#terraform workspace show
#terraform workspace list
#terraform workspace new
#terraform workspace select
#terraform workspace delete --> can't delete default workspace
```

### Note
- Terraform CLI workspace are completely different from Terraform Cloud workspace.
- For a given workspace directory, only one workspace can be selected at a time.
- Most Terraform commands (including provisioning and state manipulation commands) only interact with the currently selected workspace.

### References
- [Workspaces](https://www.terraform.io/docs/language/state/workspaces.html)
- [Managing Workspace](https://www.terraform.io/docs/cli/workspaces/index.html)