terraform {
    # It pulls terraform configuration files from "dubareddy/terragrunt-aws-demo-modules" repo, under
    # subdirectory "modules/ec2-demo" for tag "v1.0.0"
    source = "git::git@github.com:dubareddy/terragrunt-aws-demo-modules.git//modules/ec2-demo?ref=v1.0.0"

    extra_arguments "custom_vars" {
        commands = [
            "apply",
            "plan",
            "refresh"
        ]
        required_var_files = ["${get_parent_terragrunt_dir()}/common.tfvars"]
    }

    include_in_copy = [
        ".command_values.json",
        "*.yaml",
    ]

    before_hook "run_before_checks" {
        commands = ["apply", "plan"]
        execute  = ["echo", "Lets execute before plan and apply hook!!!"]
    }

    after_hook "run_after_checks" {
        commands = ["apply", "plan"]
        execute  = ["echo", "Now lets execute after plan and apply hook!!!"]
        on_errors = [
            ".*",
        ]
    }
}