# Terraform local-exec provisioner
- The local-exec provisioner invokes a local executable after a resource is created.
- This invokes a process on the machine running Terraform, not on the resource.
- Task 1
  - Lets create one provisioner during creation-time. Which should ootput private ip address of the instance into a file "ec2-private-ipaddress.txt"
  ```
  privisioner "local-exec" {
    command = "echo ${aws_instance.wen.private_ip} >> ec2-private-ipaddress.txt"
    working_dir = "local-exec-output-files/"
  }

  provisioner "local-exec" {
    when = destroy
    command = "echo Destroy-time provisioner EC2 instance at `date` >> ec2-destroy.txt"
    working_dir = "local-exec-output-files/"
  }
  ```

## Scenario 1:
```
- terraform init
- terraform validate/fmt (optional)
- terraform apply -auto-approve --> check if file "ec2-private-ipaddress.txt" was created under directory "local-exec-output-files" in current workspace.
- terraform destroy -auto-approve --> check if file "ec2-destroy.txt" file was created under directory "local-exec-output-files" in current workspace.
```