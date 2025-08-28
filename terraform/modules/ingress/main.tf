resource "kubernetes_ingress_v1" "nginx_app_ingress" {
  metadata {
    name      = var.ingress_name
    namespace = var.ingress_namespace
    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
      # Security headers
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      "nginx.ingress.kubernetes.io/ssl-passthrough"    = "false"
      "nginx.ingress.kubernetes.io/proxy-body-size"    = "10m"
      "nginx.ingress.kubernetes.io/proxy-buffer-size"  = "128k"
      "nginx.ingress.kubernetes.io/rewrite-target"     = "/"
    }
  }

  spec {
    ingress_class_name = var.ingress_class_name
    tls {
      hosts       = var.tls_hosts
      secret_name = var.tls_secret_name
    }
    dynamic "rule" {
      for_each = var.ingress_rules
      content {
        host = rule.value.host
        http {
          dynamic "path" {
            for_each = rule.value.http.paths
            content {
              path      = path.value.path
              path_type = path.value.path_type
              backend {
                service {
                  name = path.value.backend.service.name
                  port {
                    number = path.value.backend.service.port.number
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}