variable "kube_config_file" {
  description = "Path to the Kubernetes config file"
  type        = string
}

variable "kube_context" {
  description = "Kubernetes context to use"
  type        = string
}

variable "tls_path" {
  description = "Path to TLS certificates"
  type = object({
    tls-cert = string
    tls-key  = string
  })
}
