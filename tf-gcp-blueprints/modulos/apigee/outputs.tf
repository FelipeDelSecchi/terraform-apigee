output "apigee_org_id" {
  description = "ID da organização do Apigee criada."
  value       = google_apigee_organization.this.id
}

output "apigee_instance_name" {
  description = "Nome da instância do Apigee criada."
  value       = google_apigee_instance.this.name
}

output "apigee_environment_name" {
  description = "Nome do ambiente do Apigee criado."
  value       = google_apigee_environment.this.name
}

output "apigee_envgroup_name" {
  description = "Nome do EnvGroup do Apigee criado."
  value       = google_apigee_envgroup.this.name
}

output "apigee_envgroup_hostnames" {
  description = "Lista de hostnames configurados no EnvGroup."
  value       = google_apigee_envgroup.this.hostnames
}

output "external_lb_ip_address" {
  description = "Endereço IP global do Load Balancer HTTPS externo (se criado)."
  value       = try(google_compute_global_address.external[0].address, null)
}

output "external_lb_name" {
  description = "Nome base do Load Balancer HTTPS externo."
  value       = var.external_lb_name
}
