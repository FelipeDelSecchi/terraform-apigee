module "apigee" {
  source = "../../tf-gcp-blueprints/modulos/apigee"

  project_id                 = var.project_id
  apigee_org_display_name    = var.apigee_org_display_name
  apigee_analytics_region    = var.analytics_region
  apigee_runtime_location    = var.runtime_location
  apigee_billing_type        = var.apigee_billing_type
  apigee_authorized_network  = var.apigee_authorized_network

  apigee_environment_name         = var.apigee_environment_name
  apigee_environment_display_name = var.apigee_environment_display_name
  apigee_environment_description  = var.apigee_environment_description

  apigee_envgroup_name      = var.apigee_envgroup_name
  apigee_envgroup_hostnames = var.apigee_envgroup_hostnames

  labels = var.labels

  create_external_https_load_balancer = var.create_external_https_load_balancer
  external_lb_name                    = var.external_lb_name
  external_lb_cert_domains            = var.external_lb_cert_domains

  psc_neg_region     = var.psc_neg_region
  psc_neg_network    = var.psc_neg_network
  psc_neg_subnetwork = var.psc_neg_subnetwork
  psc_target_service = var.psc_target_service
}
