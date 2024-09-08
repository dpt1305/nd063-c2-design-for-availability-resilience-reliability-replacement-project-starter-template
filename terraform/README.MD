# Introduction
With the advantages of using IaC, I mainly use Terraform for provisioning resources. The purpose of each files in this folder:
- *1.config.tf* : configuration of provider and credentials.
- *2.vpc.tf* : create VPC, Subnets, Subnet groups and Route tables as long as the initial cloudformation file.
- *3.rds.tf* : create primary and secondary RDS instance
- *4.ec2.tf* : create 2 instances for connecting to 2 RDS instance

# Instruction:
- Install and set up credentials: [follow link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- Planning:
  > terraform plan

- Applying: 
  > terraform apply

- Destroying resources:
  > terraform destroy


