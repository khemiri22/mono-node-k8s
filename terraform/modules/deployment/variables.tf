variable "deployment_name" {
  description = "The name of the Kubernetes deployment"
  type        = string
  default     = "nginx-app-deployment"
}

variable "namespace" {
  description = "The Kubernetes namespace to deploy the application"
  type        = string
  default     = "default"
}

variable "labels" {
  description = "Labels to apply to the Kubernetes resources"
  type        = map(string)
  default = {
    app = "nginx-app"
  }
}

variable "replicas" {
  description = "Number of replicas for the deployment"
  type        = number
  default     = 1
}

variable "image" {
  description = "Docker image to use for the nginx application"
  type        = string
  default     = "nginx:alpine"
}

variable "container_port" {
  description = "Port on which the container will listen"
  type        = number
  default     = 80
}
