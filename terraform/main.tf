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
    "tls.crt" = filebase64("${path.root}/certs/tls-cert.pem")
    "tls.key" = filebase64("${path.root}/certs/tls-key.pem")
  }
}