output "apigee_org_id" {
  description = "ID da organização do Apigee criada."
  value       = google_apigee_organization.this.id
}

output "apigee_instance_name" {
  description = "Nome da instância do Apigee criada."
  value       = google_apigee_instance.this.name
}

output "apigee_environment_names" {
  description = "Lista de nomes dos ambientes do Apigee criados."
  value       = [for k, env in google_apigee_environment.this : env.name]
}

output "apigee_envgroup_names" {
  description = "Lista de nomes dos EnvGroups do Apigee criados."
  value       = [for k, eg in google_apigee_envgroup.this : eg.name]
}

output "apigee_envgroup_hostnames" {
  description = "Mapa de EnvGroups e seus hostnames configurados."
  value       = { for k, eg in google_apigee_envgroup.this : k => eg.hostnames }
}

output "external_lb_ip_address" {
  description = "Endereço IP global do Load Balancer HTTPS externo (se criado)."
  value       = try(google_compute_global_address.external[0].address, null)
}

output "external_lb_name" {
  description = "Nome base do Load Balancer HTTPS externo."
  value       = var.external_lb_name
}
