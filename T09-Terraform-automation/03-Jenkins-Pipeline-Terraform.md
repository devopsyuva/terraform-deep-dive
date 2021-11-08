# Jenkins Pipeline for Terraform IaC Deployment

## Pre-request:
- Ubuntu 20.04 LTS Server Image
- Install Java 11 using below command:
  ```
  sudo apt-get install -y openjdk-11-jdk
  ```
## Jenkins Installation and Setup:
- Now, install Jenkins LTS version as recommended:
  ```
  wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
  sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
  sudo apt-get update
  sudo apt-get install jenkins
  ```
- After successful installation, access Jenkins Setup Wizard to configure further:
  - Access Setup Wizard in the browser
  ```
  http://<public-ipaddress>:8080
  ```
  - Give initialAdminPassword fetched from /var/lib/jenkins/secrets/initialAdminPassword file
  - select "Install Suggested Plugins"
  - After provider admin username and password to access the dashboard further

## Setup and configure Terraform plugin
- Install "terraform plugin": Manage Jenkins --> Manage Plugins --> Select "Available" tab --> In search type "terraform" --> select "install without restart" --> Once done, click on "Go back to the top page"
- Enable "Terraform": Manage Jenkins --> Global Tool Configuration --> Terraform section --> Add Terraform --> Name(Terraform),select "Install automatically", install from bintary.com, select "Terraform 11029 linux(amd64)" --> Save

### References:
- [Jenkins](https://www.jenkins.io/doc/book/installing/linux/)