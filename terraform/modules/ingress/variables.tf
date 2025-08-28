variable "ingress_name" {
  description = "The name of the Ingress resource"
  default     = "nginx-ingress"
  type        = string
}

variable "ingress_namespace" {
  description = "The namespace of the Ingress resource"
  default     = "default"
  type        = string
}

variable "ingress_class_name" {
  description = "The ingress class name"
  default     = "nginx"
  type        = string
}


variable "tls_secret_name" {
  description = "The name of the secret resource"
  default     = "nginx-app-tls"
  type        = string
}

variable "tls_hosts" {
  description = "The hosts for the TLS secret"
  default     = ["app.kube.local"]
  type        = list(string)
}

variable "ingress_rules" {
  description = "Map of host/path to service and port"
  type = list(object({
    host = string
    http = object({
      paths = list(object({
        path      = string
        path_type = string
        backend = object({
          service = object({
            name = string
            port = object({
              number = number
            })
          })
        })
      }))
    })
  }))
  default = [
    {
      host = "app.kube.local"
      http = {
        paths = [
          {
            path      = "/"
            path_type = "Prefix"
            backend = {
              service = {
                name = "nginx-app-service"
                port = {
                  number = 80
                }
              }
            }
          }
        ]
      }
    }
  ]
}