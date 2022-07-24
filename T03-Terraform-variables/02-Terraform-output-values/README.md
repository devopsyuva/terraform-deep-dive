# Terraform Output Values
- Terraform output values are like the return values like any other tool/language.
- A root module can use outputs to print certain values in the CLI output after running **terraform plan/apply**.
- A child module can use outputs to expose a subset of its resource attributes to a parent module.
- When using remote state, root module outputs can be accessed by other configurations via a **terraform_remote_state data source**.
```
#terraform apply [-auto-approve]

To display only outputs of the root module which reads information from "terrform.tfstate" file.
#terraform output --> prints all output details
#terraform output ec2_instance_public_dns --> Prints specified output passed
```
- How to print output in JSON format #terraform output -json.
- We should get non-redacted original value from **terraform.tfstate** file even after adding "sensitive" parameter to output values.
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

ec2_instance_device_name = [
  "/dev/sda1",
  "/dev/sda1",
  "/dev/sda1",
]
ec2_instance_private_ip = [
  "172.31.87.190",
  "172.31.90.6",
  "172.31.93.212",
]
ec2_instance_public_dns = <sensitive>
ec2_instance_public_ip = [
  "54.89.73.36",
  "52.207.236.69",
  "44.202.245.109",
]
```
## References
- [Output values](https://www.terraform.io/docs/language/values/outputs.html)