resource "kubernetes_service_v1" "nginx_app_service" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
  }

  spec {
    selector = var.labels
    type     = var.service_type
    dynamic "port" {
      for_each = var.ports
      content {
        port        = port.value.port
        target_port = port.value.target_port
      }
    }
  }
}