# Terraform Provisioners
- Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers.
- Passing data into virtual machines and other compute resources.
- Running configuration management software (packer, chef, ansible etc.,).
- Provisioners are a Last resort.
- First-class terraform provider functionality may be available.
- Creation-time provisioners.
- Destroy-time provisioners.
- Failure behavior --> continue or fail
  - Continue: Ingore the error and continue with creation or destruction.
  - Fail: Raise an error and stop applying(default behavior). If creation provisioner, taint resource.

## Porvisioner Types
- File Provisioner
- remote-exec Provisioner
- local-exec Provisioner
### File provisioner
- File provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource.
- The file provisioner supports both ssh and winrm type of connections
```
provisioner "file" {
    source = "apps/apache-install.sh"
    destination = "/tmp/apache-install.sh"
}
```
### local-exec Provisioner
- The local-exec provisioner invokes a local executable after a resource is created.
- This invokes a process on the machine running Terraform, not on the resource.
```
provisioner "local-exec" {
    when = destroy
    command = "echo ${aws_instance.web.private_ip} >> ec2-private-ip-address.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
}
```
### remote-exec Provisioner
- The remote-exec provisioner invokes a script on a remote resource after it is created.
- This can be used to run a configuration management tool, bootstrap inti a cluster, etc.
```
provider "file" {
    source = "apps/index.html"
    destination = "/tmp/index.html"
}
provisioner "remote-exec" {
    inline = [
        "sleep 1200",
        "sudo cp /tmp/index.html /var/www/html"
    ]
}
```
### Null-resources & Provisioners
- If you need to run provisioners that aren't directly associated with a specific resource, you can associate them with a null_resource.
- Instances of null_resource are tested like normal resources, but they don't do anything.
- Same as other resource, you can configure provisioners and connection details on a null_resource.
```
#wait for 90 seconds after creating the above
resource "time_sleep" "wait_90_seconds" {
    depends_on = [aws_instance.web]
    create_duration = "90s"
}

#sync app1 static content to webserver
resource "null_resource" "sync_app1_static" {
    depends_on = [ time_sleep.wait_90_seconds ]
    triggers = {
        always-update = timestamp() // When ever terraform apply run this will be triggered with updated timestamp
    }
}


#connection block for provisioner to connect EC2
connection {
    type = "ssh"
    host = aws_instance.web.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
}

#copies app1 folder to /tmp
provisioner "file" {
    source = "apps/app1"
    destination = "/tmp"
}

#copies the /tmp/app1 folder to apache webserver
provisioner "remote-exec" {
    inline = [
        "sudo cp -r /tmp/app1 /var/www/html"
    ]
}
```

## Connection Block
- Most of the provisioners require access to the remote resource via SSH or WinRM, and expect a nested connection block wit details about how to connect.
- Expressions in connection block cannot refer to their parent resource by name. Instead, they can use the special self object.
```
connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
}
```

### References
- [Provisioners](https://www.terraform.io/docs/language/resources/provisioners/syntax.html)