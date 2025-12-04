output "external_lb_ip_address" {
  description = "Endereço IP global do Load Balancer HTTPS externo."
  value       = google_compute_global_address.external.address
}

output "external_lb_name" {
  description = "Nome base do Load Balancer HTTPS externo."
  value       = var.external_lb_name
}
