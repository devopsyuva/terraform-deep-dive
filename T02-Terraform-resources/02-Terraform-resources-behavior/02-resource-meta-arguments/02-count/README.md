# Terraform Resource Meta-arguments using count
- If we need to create multiple same resource with single configuration file, then count will be a right choice.
- Value for count will be a integer. For example count = 3, will create 3 instances in AWS.
- These three objects for example will be distinct from each other while created, updated or destroyed while applying configuration files.
- count.index will be distinct index number(starts from 0) corresponding to this instance.
- Instances are identified using index number starting from 0. For example: aws_instance.web[0]/[1]/[2]
- Modules support count from terraform v0.13.
- A resource or module can't use both **count and for_each** at a time.

## References
- [Count Meta-Argument](https://www.terraform.io/docs/language/meta-arguments/count.html)