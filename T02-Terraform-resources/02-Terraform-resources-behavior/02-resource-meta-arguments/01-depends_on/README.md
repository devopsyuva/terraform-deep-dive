# depends_on demo creation flow
- Create ssh key for instance to login from our machine in AWS console
- Create VPC
- Create Subnets (Public and Private)
- Create Internet Gateway and attach it to VPC
- Create Route table for public and private
- Attach the IGW route to Public route table for internet access
- Associate Public subnet to public route table and Private subnet to private route table
- Create a Security group to VPC to allow 22 and 80 port inbound rule
- Launch Instance on above specified resources and install web server
- Create EIP, which depends_on IGW
## Note:
- Destroy everything (#terraform destroy and rm -rf .terraform* terraform.tfstate*)