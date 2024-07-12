# terraform-examples

This repo contains sample .tf scripts for managing Temporal Cloud resources with the Temporal Terraform Provider.


/provideronly - this is a blank terraform config file that contains the temporal cloud provider
- you can use this file to test if your tf environment can access/download the temporal provider
- to run this sample:
  - initialize terraform with `terraform init`
  - plan terraform with `terraform plan`
  - apply terraform changes with `terraform apply`


/simple - contains a simple example terraform.tf file that manages a Namespace and User resource 
- before running this sample
  - replace the user resource email with a real email address
  - generate a ca cert and replace the namespace accepted_client_ca file value with the path/file name of your ca cert
- to run this sample:
  - initialize terraform with `terraform init`
  - plan terraform with `terraform plan`
  - apply terraform changes with `terraform apply`


/import - contains a terraform.tf that can be used in conjunction with the terraform CLI import command 
- terraform also supports import blocks to use instead of the cli import command.  Further reading is here - https://developer.hashicorp.com/terraform/language/import
- to run this sample:
  - initialize terraform with `terraform init`
  - import a namespace in terraform with `terraform import` and pass in the resource name temporalcloud_namespace.namespace and the namespace you would like to import 
  - for example `terraform import temporalcloud_namespace.namespace <yournamespace.acctid>` will import an existing namespace into your terraform state


/certgen - provides a more production like terraform configuration example that demonstrates how to use:
- variables to pass in values to a terraform.tf config file
- local variables to pass in variables that are specific for your local environment
- Hashi's CA cert generation provider to generate and load x509.v3 into a namespace
- to run this sample:
  - add your global and local variable values in the terraform.tfvars and locals.tf files
   - replace <yournamespacenamegoeshere> with your namespace name in terraform.tfvars
   - replace <youracctidgoeshere> with your account id in locals.tf
  - initialize terraform with `terraform init`
  - plan terraform with `terraform plan`
  - apply terraform changes with `terraform apply`
