# Terraform Unit Testing using Sentinel Framework

## Why Policy as Code?
- Terraform is used to build Infrastructure as a Code approach to manage target provider Infrastructure.
- **Sentinel Framework** was developed for "Policy as Code" approach applied to infrastructute can be very effective in enforcing and managing policies.
- Note:
  - Sentinel is a framework for policy as code that we introduced and have integrated into Terraform Enterprise, Vault Enterprise, Nomad Enterprise, and Consul Enterprise.

## What is Policy?
- **Compliance Policies:** These policies ensure compliance with external standards such as PCI-DSS, SOC, or GDPR. External industry working groups or government agencies establish and mandate these standards.
- **Security Policies:** Security policies adopted internally protect data privacy and infrastructure integrity. For example, ensuring only certain applications run on public networks or expose specific ports to the Internet.
- **Operational Excellence:** These policies prevent service outages or degradation. For example, a policy may mandate at least two service instances, or validation of new configurations.

## What is Policy as Code?
- This approach allows configuration to be tested, peer reviewed, versioned, automated, and re-used much like application code.
- Treating policy as code requires a way to specify policies and a mechanism to enforce them.
- Traditionally, policies were defined in Word documents and enforced manually. Instead, Sentinel provides a simple policy-oriented language to write policies, and integrates with our tools like Terraform Enterprise and Nomad Enterprise to enforce them.
```
import "tfplan"

valid_regions = {"production": "us-west-1", "staging": "us-east-1"}
env_region = valid_regions[tfplan.variables.env]

is_not_aws = func(type) {
	return type is not "aws"
}

// Check the provider alias region matches the environment region
validate_aws_region = func(provider) {
	return all provider.alias as a {
		a.config.region is env_region
	}
}

main = rule {
	all tfplan.config.providers as type, provider {
		is_not_aws(type) or validate_aws_region(provider)
	}
}
```

## Enforcement Levels
- Advisory
- Soft Mandatory
- Hard Mandatory

### References:
- [Policy as a Code](https://www.hashicorp.com/blog/why-policy-as-code)
- [Sentinel Enterprise](https://www.terraform.io/docs/cloud/sentinel/sentinel-tf-012.html)
- [Changelog](https://docs.hashicorp.com/sentinel/changelog)
- [Sentinel](https://docs.hashicorp.com/sentinel/intro/what)