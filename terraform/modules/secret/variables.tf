variable "secret_name" {
  description = "The name of the secret resource"
  default     = "nginx-app-tls"
  type        = string
}

variable "secret_namespace" {
  description = "The namespace of the secret resource"
  default     = "default"
  type        = string
}

variable "tls_certs" {
  description = "The path to the TLS certificate files"
  type        = map(string)
  sensitive   = true
}
