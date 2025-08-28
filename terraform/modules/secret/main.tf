resource "kubernetes_secret_v1" "tls-certificate" {
  metadata {
    name      = var.secret_name
    namespace = var.secret_namespace
  }

  type = "kubernetes.io/tls"

  binary_data = var.tls_certs
}