# Connection Block for File Provisioner
- **Connection Block:**
  - we can have connection block inside resource block for all provisioners or We can have connection block inside a provisioner block for that respective provisioner.
- **Self Object:**
  - Resource references are restricted here because references create dependencies. Referring to a resource by name with its own block would create a dependency cycle.
  - Expressions in provisioner blocks cannot refer to their parent by name. Instead, they can use the special self object.
  - The self object represents the provisioner's parent resource, and has all of that resource's attributes.
  ```
  connection {
      type = "ssh"
      host = self.public_ip #Lets see what is self
      user = "ec2-user"
      password = ""
      private_key = file("private-key/terraform-key.pem")
  }
  ```

## Scenario 1 (file provisioner):
- terraform init --> Initialize terraform
- terraform validate/fmt (optional)
- terraform plan --> Check if all resources will get created as expected
- terraform apply [-auto-approve] --> we can see the output about provisioner details
- ssh -i private-key/terraform-key.pem ec2-user@<public_ip>
- Verify if index.html file was copied to /tmp directory in the EC2 instance.

## Scenario 2 (file provisioner with on_failure=continue/fail):
- Default (fail) to take a decision for failure provisioner scenario if resource to be created or not. Fail will stop the resource creation and will taint it. Where as continue will create resource even for failed provisioner.
- Test 1
  - with no on_failure section or on_failure=fail in provisioner
  ```
  - terraform init --> Initialize terraform
  - terraform validate/fmt (optional)
  - terraform plan --> Check if all resources will get created as expected
  - terraform apply [-auto-approve] --> we can see the output about provisioner details
  # Above apply command should fail for instance resource creation while uploading the file, but instance will be created. Which a taint will be marked for the failed resource.
  # Now lets re-execute command #terraform apply and we could see that instance resource will be recreated in the message "-/+destroy and then create replacement".
  # Check the same thing in terraform.tfstate file as well for reference.
  ```
- Test 2
  - with on_failure=continue section in provisioner
  ```
  - terraform apply -auto-approve --> It will not through any error since on_failure=continue was set to that resource provisioner. Where we can see no taint was marked for the resource.
  #check the same in terrform.tftstate or execute terraform apply command
  ```
- Test 3
  - Now to avoid the failure in provisioner, lets add sudo to remote-exec provisioner in next topic "03-remote-exec-provisioner".