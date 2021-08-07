# Install/Setup terraform on Ubuntu 20.04 LTS server
- Download the zip package using below command
```
1) check system details
root@ubuntuserverdocker:~# lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.2 LTS
Release:        20.04
Codename:       focal
root@ubuntuserverdocker:~#

2) Download terraform zip file
root@ubuntuserverdocker:~# wget https://releases.hashicorp.com/terraform/1.0.3/terraform_1.0.3_linux_amd64.zip
--2021-08-02 05:16:15--  https://releases.hashicorp.com/terraform/1.0.3/terraform_1.0.3_linux_amd64.zip
Resolving releases.hashicorp.com (releases.hashicorp.com)... 199.232.253.183, 2a04:4e42:fd3::439
Connecting to releases.hashicorp.com (releases.hashicorp.com)|199.232.253.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 32406882 (31M) [application/zip]
Saving to: ‘terraform_1.0.3_linux_amd64.zip’

terraform_1.0.3_linux_amd64. 100%[==============================================>]  30.91M  3.38MB/s    in 9.1s

2021-08-02 05:16:25 (3.41 MB/s) - ‘terraform_1.0.3_linux_amd64.zip’ saved [32406882/32406882]

root@ubuntuserverdocker:~#

3) Unzip the file and move terraform executable file to default binary location to execute as command
root@ubuntuserverdocker:~# apt install unzip
Reading package lists... Done
Building dependency tree
Reading state information... Done
Suggested packages:
  zip
The following NEW packages will be installed:
  unzip
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 169 kB of archives.
After this operation, 593 kB of additional disk space will be used.
Get:1 http://in.archive.ubuntu.com/ubuntu focal/main amd64 unzip amd64 6.0-25ubuntu1 [169 kB]
Fetched 169 kB in 0s (385 kB/s)
Selecting previously unselected package unzip.
(Reading database ... 71449 files and directories currently installed.)
Preparing to unpack .../unzip_6.0-25ubuntu1_amd64.deb ...
Unpacking unzip (6.0-25ubuntu1) ...
Setting up unzip (6.0-25ubuntu1) ...
Processing triggers for mime-support (3.64ubuntu1) ...
Processing triggers for man-db (2.9.1-1) ...
root@ubuntuserverdocker:~# ls -l
total 31652
drwxr-xr-x 3 root root     4096 Aug  2 02:05 snap
-rw-r--r-- 1 root root 32406882 Jul 21 18:49 terraform_1.0.3_linux_amd64.zip
root@ubuntuserverdocker:~# unzip terraform_1.0.3_linux_amd64.zip
Archive:  terraform_1.0.3_linux_amd64.zip
  inflating: terraform
root@ubuntuserverdocker:~# ls -lrt
total 108196
-rwxr-xr-x 1 root root 78380697 Jul 21 18:22 terraform
-rw-r--r-- 1 root root 32406882 Jul 21 18:49 terraform_1.0.3_linux_amd64.zip
root@ubuntuserverdocker:~# mv terraform /usr/local/bin/

4) Now check the terraform version
root@ubuntuserverdocker:~# terraform --version
Terraform v1.0.3
on linux_amd64
root@ubuntuserverdocker:~#
```
# Install AWS cli to configure AWS credentials to run terraform API calls
1) Download latest AWS cli package
root@ubuntuserverdocker:~# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

2) unzip downloaded package and place in proper binary location
root@ubuntuserverdocker:~# unzip awscliv2.zip
root@ubuntuserverdocker:~# ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

3) Now configure the AWS credentails for cli to intract
root@ubuntuserverdocker:~# aws configure
Note: give AWS user secret access key and access key (Optional: Region)

4) Excute commands like **#aws s3 ls** command and see it was able to authenticate and fetch the details of buckts if any from the account

# References
[AWS Free trail](https://aws.amazon.com/free/)
[AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
[Terraform Download](https://www.terraform.io/downloads.html)