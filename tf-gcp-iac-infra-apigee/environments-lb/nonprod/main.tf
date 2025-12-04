module "apigee_lb" {
  source = "../../../tf-gcp-blueprints/modulos/apigee_lb"

  external_lb_name         = var.external_lb_name
  external_lb_cert_domains = var.external_lb_cert_domains

  psc_neg_region     = var.psc_neg_region
  psc_neg_network    = var.psc_neg_network
  psc_neg_subnetwork = var.psc_neg_subnetwork
  psc_target_service = var.psc_target_service

  labels = var.labels
}
