resource "kubernetes_deployment_v1" "nginx-app-deployment" {
  metadata {
    name      = var.deployment_name
    namespace = var.namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = var.labels
    }

    template {
      metadata {
        labels = var.labels
      }

      spec {
        container {
          name  = "nginx-app-container"
          image = var.image

          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}