# Terraform Input Variables to override using -var option in CLI
- We will define default values in variables.tf file.
- These values like instance_type and few will be overridden by passing argument "-var" in CLI.
- Execute below command in this demo to override "inst_type=t3.micro" and "count=2".
```
#terraform plan/apply -var="inst_type=t3.micro" -var="inst_count=2 [-auto-approve]"

or

#we can generate a plan file using terraform plan command "-out demo_test.out"
#Now we can use that file to apply and no need to pass -var option now. Since those values are already registered in plan to file passed.
```