variable "service_name" {
  description = "The name of the Kubernetes service"
  type        = string
  default     = "nginx-app-service"
}

variable "labels" {
  description = "Labels to apply to the Kubernetes resources"
  type        = map(string)
  default = {
    app = "nginx-app"
  }
}

variable "namespace" {
  description = "The Kubernetes namespace to deploy the application"
  type        = string
  default     = "default"
}

variable "ports" {
  description = "The service ports for the application"
  type        = list(map(string))
  default = [
    {
      port        = 80
      target_port = 80
    }
  ]
}

variable "service_type" {
  description = "The type of Kubernetes service"
  type        = string
  default     = "ClusterIP"

}