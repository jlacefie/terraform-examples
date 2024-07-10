terraform {
  required_providers {
    temporalcloud = {
      source = "temporalio/temporalcloud"
      version = ">= 0.0.6" 
    }
  }
}

provider "temporalcloud" {

}

resource "temporalcloud_namespace" "namespace" {
	name               = "terraform"
	regions            = ["aws-us-east-1"]
	accepted_client_ca = base64encode(file("ca.pem"))
	retention_days     = 15
        lifecycle {
          prevent_destroy = true
       } 
}

resource "temporalcloud_namespace" "jltesttfimport" {

}

resource "temporalcloud_user" "developer" {
  email          = "jltest@temporal.io"
  account_access = "Developer"
  namespace_accesses = [
      {
      namespace_id = temporalcloud_namespace.namespace.id
      permission = "Write"
    }
 ]      
}

