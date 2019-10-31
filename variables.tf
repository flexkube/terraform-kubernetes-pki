# Required variables
variable "root_ca_cert" {
  description = "Root CA certificate."
  type        = string
}

variable "root_ca_key" {
  description = "Root CA key."
  type        = string
}

variable "root_ca_algorithm" {
  description = "Root CA algorithm."
  type        = string
}

variable "api_server_external_names" {
  description = "External FQDNs where Kubernetes API server should be accessible."
  default     = []
}

variable "api_server_external_ips" {
  description = "External IP addresses where Kubernetes API server should be accessible."
  default     = []
}

# Optional variables
variable "api_server_ips" {
  description = "Kubernetes API server IP addresses."
  default     = []
}

variable "rsa_bits" {
  description = "Default number of RSA bits for certificates."
  type        = string
  default     = "4096"
}

variable "organization" {
  description = "Organization field for certificates."
  type        = string
  default     = "organization"
}
