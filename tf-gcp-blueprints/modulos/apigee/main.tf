locals {
  apigee_org_display_name = coalesce(var.apigee_org_display_name, var.project_id)
}

# Organização do Apigee
resource "google_apigee_organization" "this" {
  project_id         = var.project_id
  display_name       = local.apigee_org_display_name
  analytics_region   = var.apigee_analytics_region
  billing_type       = var.apigee_billing_type
  authorized_network = var.apigee_authorized_network
}

# Instância do Apigee
resource "google_apigee_instance" "this" {
  name     = "apigee-instance"
  org_id   = google_apigee_organization.this.id
  location = var.apigee_runtime_location
}

# Ambientes do Apigee (multi-env)
resource "google_apigee_environment" "this" {
  for_each = var.apigee_environments

  org_id       = google_apigee_organization.this.id
  name         = each.key
  display_name = coalesce(each.value.display_name, each.key)
  description  = lookup(each.value, "description", null)
}

# Anexar ambientes à instância
resource "google_apigee_instance_attachment" "this" {
  for_each    = google_apigee_environment.this
  instance_id = google_apigee_instance.this.id
  environment = each.value.name
}

# EnvGroups do Apigee (multi-envgroup)
resource "google_apigee_envgroup" "this" {
  for_each = var.apigee_envgroups

  org_id    = google_apigee_organization.this.id
  name      = each.key
  hostnames = each.value.hostnames
}

# Anexar EnvGroups aos ambientes configurados
resource "google_apigee_envgroup_attachment" "this" {
  # Cria um attachment para cada par EnvGroup/Ambiente definido na variável apigee_envgroups
  for_each = {
    for eg_name, eg in var.apigee_envgroups :
    # cria uma entrada por ambiente associado
    for env_name in eg.environments :
    "${eg_name}-${env_name}" => {
      envgroup = eg_name
      env      = env_name
    }
  }

  envgroup_id = google_apigee_envgroup.this[each.value.envgroup].id
  environment = google_apigee_environment.this[each.value.env].name
}

####################################
# Load Balancer HTTPS Externo (PSC)
####################################

resource "google_compute_region_network_endpoint_group" "psc_neg" {
  count                 = var.create_external_https_load_balancer ? 1 : 0
  name                  = "${var.external_lb_name}-psc-neg"
  region                = var.psc_neg_region
  network               = var.psc_neg_network
  subnetwork            = var.psc_neg_subnetwork
  network_endpoint_type = "PRIVATE_SERVICE_CONNECT"

  psc_target_service = coalesce(
    var.psc_target_service,
    google_apigee_instance.this.service_attachment
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_backend_service" "apigee_psc_backend" {
  count                 = var.create_external_https_load_balancer ? 1 : 0
  name                  = "${var.external_lb_name}-backend"
  description           = "Backend service para expor o Apigee via Private Service Connect."
  protocol              = "HTTPS"
  port_name             = "https"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = google_compute_region_network_endpoint_group.psc_neg[0].self_link
  }

  dynamic "log_config" {
    for_each = length(var.labels) > 0 ? [1] : []
    content {
      enable = true
    }
  }
}

resource "google_compute_global_address" "external" {
  count = var.create_external_https_load_balancer ? 1 : 0
  name  = "${var.external_lb_name}-ip"
}

resource "google_compute_managed_ssl_certificate" "default" {
  count = var.create_external_https_load_balancer ? 1 : 0
  name  = "${var.external_lb_name}-cert"

  managed {
    domains = var.external_lb_cert_domains
  }
}

resource "google_compute_url_map" "https" {
  count           = var.create_external_https_load_balancer ? 1 : 0
  name            = "${var.external_lb_name}-url-map"
  default_service = google_compute_backend_service.apigee_psc_backend[0].self_link
}

resource "google_compute_target_https_proxy" "https" {
  count        = var.create_external_https_load_balancer ? 1 : 0
  name         = "${var.external_lb_name}-https-proxy"
  url_map      = google_compute_url_map.https[0].self_link
  ssl_certificates = [
    google_compute_managed_ssl_certificate.default[0].self_link
  ]
}

resource "google_compute_global_forwarding_rule" "https" {
  count                 = var.create_external_https_load_balancer ? 1 : 0
  name                  = "${var.external_lb_name}-https-fr"
  ip_protocol           = "TCP"
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target                = google_compute_target_https_proxy.https[0].self_link
  ip_address            = google_compute_global_address.external[0].self_link
}
