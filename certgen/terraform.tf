terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = ">= 2.0.0"
    }
    temporalcloud = {
      source = "temporalio/temporalcloud"
      version = ">= 0.0.6"
    }
  }
}

provider "tls" {
}

provider "temporalcloud" {
}

resource "tls_private_key" "ca" {
  algorithm = "RSA"
#  rsa_bits  = 2048
}


// This is the root CA that gets upload to temporal cloud. It is not stored anywhere locally. If new
// certificates are needed you need to regenerate all of them (including the client end-entity certs).
resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem
  subject {
    common_name  = format("%s-%s.%s", var.nname, var.region[0], local.temporal_account_id)
    organization = "temporal"
  }
  allowed_uses = [
    "cert_signing",
    "server_auth",
    "client_auth",
  ]
  validity_period_hours = var.certificate_expiration_hours
  is_ca_certificate     = true
}

resource "tls_private_key" "default" {
  algorithm = "RSA"
#  rsa_bits  = 2048
}

resource "tls_cert_request" "default" {
  private_key_pem = tls_private_key.default.private_key_pem
  dns_names       = []
  subject {
    common_name  = format("%s-%s.%s", var.nname, var.region[0], local.temporal_account_id)
    organization = "temporal"
  }
}

// This is the end-entity cert that is used to authorize the workers connecting to temporal cloud.
// This gets stored in vault.
resource "tls_locally_signed_cert" "default" {
  cert_request_pem   = tls_cert_request.default.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem
  validity_period_hours = var.certificate_expiration_hours
  allowed_uses = [
    "client_auth",
    "digital_signature"
  ]
  is_ca_certificate = false
}

resource "temporalcloud_namespace" "jltesttfimport" {
  
	name               = var.nname
	regions            = var.region
	accepted_client_ca = base64encode(tls_self_signed_cert.ca.cert_pem)
	retention_days     = var.retention_days
}