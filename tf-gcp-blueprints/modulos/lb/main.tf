resource "google_compute_region_network_endpoint_group" "psc_neg" {
  name                  = "${var.external_lb_name}-psc-neg"
  region                = var.psc_neg_region
  network               = var.psc_neg_network
  subnetwork            = var.psc_neg_subnetwork
  network_endpoint_type = "PRIVATE_SERVICE_CONNECT"

  psc_target_service = var.psc_target_service

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_backend_service" "apigee_psc_backend" {
  name                  = "${var.external_lb_name}-backend"
  description           = "Backend service para expor o Apigee via Private Service Connect."
  protocol              = "HTTPS"
  port_name             = "https"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = google_compute_region_network_endpoint_group.psc_neg.self_link
  }

  dynamic "log_config" {
    for_each = length(var.labels) > 0 ? [1] : []
    content {
      enable = true
    }
  }
}

resource "google_compute_global_address" "external" {
  name = "${var.external_lb_name}-ip"
}

resource "google_compute_managed_ssl_certificate" "default" {
  name = "${var.external_lb_name}-cert"

  managed {
    domains = var.external_lb_cert_domains
  }
}

resource "google_compute_url_map" "https" {
  name            = "${var.external_lb_name}-url-map"
  default_service = google_compute_backend_service.apigee_psc_backend.self_link
}

resource "google_compute_target_https_proxy" "https" {
  name    = "${var.external_lb_name}-https-proxy"
  url_map = google_compute_url_map.https.self_link
  ssl_certificates = [
    google_compute_managed_ssl_certificate.default.self_link
  ]
}

resource "google_compute_global_forwarding_rule" "https" {
  name                  = "${var.external_lb_name}-https-fr"
  ip_protocol           = "TCP"
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target                = google_compute_target_https_proxy.https.self_link
  ip_address            = google_compute_global_address.external.self_link
}
