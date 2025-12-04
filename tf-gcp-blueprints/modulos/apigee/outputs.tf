output "apigee_org_id" {
  description = "ID da organização do Apigee criada."
  value       = google_apigee_organization.this.id
}

output "apigee_instance_name" {
  description = "Nome da instância do Apigee criada."
  value       = google_apigee_instance.this.name
}

output "apigee_instance_service_attachment" {
  description = "Service attachment PSC da instância do Apigee (para consumo pelo LB)."
  value       = google_apigee_instance.this.service_attachment
}

output "apigee_environment_names" {
  description = "Lista de nomes dos ambientes do Apigee criados."
  value       = [for _, env in google_apigee_environment.this : env.name]
}

output "apigee_envgroup_names" {
  description = "Lista de nomes dos EnvGroups do Apigee criados."
  value       = [for k, _ in google_apigee_envgroup.this : k]
}

output "apigee_envgroup_hostnames" {
  description = "Mapa de EnvGroups e seus hostnames configurados."
  value       = { for k, eg in google_apigee_envgroup.this : k => eg.hostnames }
}
