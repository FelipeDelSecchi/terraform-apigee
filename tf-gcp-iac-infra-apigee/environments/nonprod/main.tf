module "apigee" {
  source = "../../../tf-gcp-blueprints/modulos/apigee"

  project_id              = var.project_id
  apigee_org_display_name = var.apigee_org_display_name

  apigee_analytics_region   = var.analytics_region
  apigee_runtime_location   = var.runtime_location
  apigee_billing_type       = var.apigee_billing_type
  apigee_authorized_network = var.apigee_authorized_network

  apigee_environments = var.apigee_environments
  apigee_envgroups    = var.apigee_envgroups

  labels         = var.labels
  apigee_ip_range = var.apigee_ip_range
}
