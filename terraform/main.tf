module "deployment" {
  source = "./modules/deployment"
}

module "service" {
  source = "./modules/service"
}

module "ingress" {
  source = "./modules/ingress"
}

module "secret" {
  source = "./modules/secret"
  tls_certs = {
    "tls.crt" = filebase64("${var.tls_path.tls-cert}")
    "tls.key" = filebase64("${var.tls_path.tls-key}")
  }
}