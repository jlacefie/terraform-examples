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

