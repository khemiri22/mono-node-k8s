terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.38.0"
    }
  }
}

provider "kubernetes" {
  config_path    = var.kube_config_file
  config_context = var.kube_context
}