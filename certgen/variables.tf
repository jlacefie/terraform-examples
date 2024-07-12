# variables.tf

variable "nname" {
  description = "The name of the namespace"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = list(string)
}

variable "certificate_expiration_hours" {
  description = "The number of hours for which the certificate is valid"
  type        = number
  default     = 8760 # 1 year by default
}

variable "retention_days" {
  description = "The number of days to retain namespace wf event history"
  type        = number
  default     = 15
}
