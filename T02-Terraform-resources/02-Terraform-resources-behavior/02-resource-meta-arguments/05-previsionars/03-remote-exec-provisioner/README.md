# Terraform remote-exec provisioner
- From file provisioner tasks we understood that provisioner was added with on_failure=continue to skip the failure.
- This is always not a good practice to skip, but instead to be resolved with other approches Terraform providers. For example, with remote-exec to copy file to /usr/share/nginx/html with sudo user.
- The remote-exec provisioner invokes a script on a remote resource after it is created.
- This can be used to run a configuration management tool, bootstrap into a cluster, etc.
```
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }
  provisioner "file" {
    source = "apps/index.html"
    destination = "/tmp/index.html"
  }
  provisioner "remote-exec" {
    inline = [
      "sleep 120" # will sleep for 120 seconds to ensure apache package installed and running
      "sudo cp /tmp/index.html /var/www/html /usr/share/nginx/html"
    ]
  }
```