## Scenario 1 to test
```
#Initialize terraform
terraform init

#List workspaces
terraform workspace list --> * will be displayed for current used workspace

#Output current workspace using show
terraform workspace show

#Terraform plan
terraform plan --> for default it should show 2 instances creation

#review and apply
terraform apply [-auto-approve]

#check if all instances are created as per specified in default workspace value
```

## Scenario 2 to test
```
#Create new workspace
terraform workspace new dev

#Verify the folder
cd terraform.tfstate.d
ls -l --> should display dev directory as per name passed above
cd dev && ls -l --> To check/list files in dev directory

#Terraform pla and apply
terraform plan --> will show as it creats only one instance since other than default workspace it uses 1

terraform apply [-auto-approve]

#After apply, check state file was created for dev workspace under "terraform.tfstate.d/dev"
```

## Scenario 3 to test
```
#Show current workspace
terraform workspace show

#List workspaces
terraform workspace list

#select workspace to switch to dev from default
terraform workspace select dev

#Delete resources from default workspace
terraform destroy [-auto-approve]

#verify if all resources related to default workspace are cleaned up
```

## Scenario 4 to test
```
#we can't delete default workspace from terraform
#Switch to other workspace and delete the workspace which you want apart from one we are currently active.

terraform workspace show
terraform workspace delete dev --> First we have to delete the resources and then remove the workspace which results in dangling resources.
terraform workspace show --> check if still that workspace exists
```

## Reference sample module directory structure:
```
root@terraformworkstation:~/terraform-aws/modules/s3-module# tree -a ../
../
├── ami-datasource.tf
├── instance.tf
├── nginx-install.sh
├── output.tf
├── provider.tf
├── s3-module
├── security-group-rules.tf
├── security-group.tf
├── .terraform
│   ├── modules
│   │   ├── ec2_cluster
│   │   │   ├── CHANGELOG.md
│   │   │   ├── .chglog
│   │   │   │   ├── CHANGELOG.tpl.md
│   │   │   │   └── config.yml
│   │   │   ├── .editorconfig
│   │   │   ├── examples
│   │   │   │   ├── basic
│   │   │   │   │   ├── main.tf
│   │   │   │   │   ├── outputs.tf
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── variables.tf
│   │   │   │   │   └── versions.tf
│   │   │   │   └── volume-attachment
│   │   │   │       ├── main.tf
│   │   │   │       ├── outputs.tf
│   │   │   │       ├── README.md
│   │   │   │       ├── variables.tf
│   │   │   │       └── versions.tf
│   │   │   ├── .git
│   │   │   │   ├── branches
│   │   │   │   ├── config
│   │   │   │   ├── description
│   │   │   │   ├── HEAD
│   │   │   │   ├── hooks
│   │   │   │   │   ├── applypatch-msg.sample
│   │   │   │   │   ├── commit-msg.sample
│   │   │   │   │   ├── fsmonitor-watchman.sample
│   │   │   │   │   ├── post-update.sample
│   │   │   │   │   ├── pre-applypatch.sample
│   │   │   │   │   ├── pre-commit.sample
│   │   │   │   │   ├── pre-merge-commit.sample
│   │   │   │   │   ├── prepare-commit-msg.sample
│   │   │   │   │   ├── pre-push.sample
│   │   │   │   │   ├── pre-rebase.sample
│   │   │   │   │   ├── pre-receive.sample
│   │   │   │   │   └── update.sample
│   │   │   │   ├── index
│   │   │   │   ├── info
│   │   │   │   │   └── exclude
│   │   │   │   ├── logs
│   │   │   │   │   ├── HEAD
│   │   │   │   │   └── refs
│   │   │   │   │       ├── heads
│   │   │   │   │       │   └── master
│   │   │   │   │       └── remotes
│   │   │   │   │           └── origin
│   │   │   │   │               └── HEAD
│   │   │   │   ├── objects
│   │   │   │   │   ├── info
│   │   │   │   │   └── pack
│   │   │   │   │       ├── pack-7d79a94a7962dbd2af185d6559c6c25f510aa73e.idx
│   │   │   │   │       └── pack-7d79a94a7962dbd2af185d6559c6c25f510aa73e.pack
│   │   │   │   ├── packed-refs
│   │   │   │   └── refs
│   │   │   │       ├── heads
│   │   │   │       │   └── master
│   │   │   │       ├── remotes
│   │   │   │       │   └── origin
│   │   │   │       │       └── HEAD
│   │   │   │       └── tags
│   │   │   ├── .github
│   │   │   │   └── workflows
│   │   │   │       └── pre-commit.yml
│   │   │   ├── .gitignore
│   │   │   ├── LICENSE
│   │   │   ├── main.tf
│   │   │   ├── Makefile
│   │   │   ├── outputs.tf
│   │   │   ├── .pre-commit-config.yaml
│   │   │   ├── README.md
│   │   │   ├── variables.tf
│   │   │   └── versions.tf
│   │   └── modules.json
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── aws
│                   └── 3.63.0
│                       └── linux_amd64
│                           └── terraform-provider-aws_v3.63.0_x5
├── .terraform.lock.hcl
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf

33 directories, 62 files
root@terraformworkstation:~/terraform-aws/modules/s3-module#
```