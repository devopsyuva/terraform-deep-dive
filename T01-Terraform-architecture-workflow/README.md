# Introduction to IaC
**Infrastructure as Code (IaC) is the managing and provisioning of infrastructure through code instead of through manual processes.**

Some of the tools listed below which falls under IaC:
- Terraform
- AWS CloudFormation
- Puppet
- Chef
- Ansible
- Saltstack

# Introduction to Terraform
**Terraform is an infrastructure as code (IaC) tool that allows you to build, change, and version infrastructure safely and efficiently. This includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc. Terraform can manage both existing service providers and custom in-house solutions.**
- we can automate and manage infrastructure
- OpenSoure and uses declarative language(Hashicorp Configuration Language)

# Key features of Terraform
- **IaC** we can describe our required infrastucture on specific providers like AWS, Azure, GCP, Kubernetes etc., using **Terraform High-level language** in human-readable, declarative configuration files.
- **Execution Plans** we can generate an execution plan which shows what it will do on the target Intrastucture. So that we can cross check and modify before creating it creates, updates or destroy.
- **Resource graph** it builds a resource graph and creates or modifies non-dependent resources in parallel. This allows Terraform to build resources as efficiently as possible and gives you greater insight into your infrastructure.
- **Change automation** it can apply complex changesets to your infrastructure with minimal human interaction. When you update configuration files, Terraform determines what changed and creates incremental execution plans that respect dependencies.