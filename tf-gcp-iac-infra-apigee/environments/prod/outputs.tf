output "apigee_org_id" {
  description = "ID da organização do Apigee criada."
  value       = module.apigee.apigee_org_id
}

output "apigee_instance_name" {
  description = "Nome da instância do Apigee criada."
  value       = module.apigee.apigee_instance_name
}

output "apigee_environment_names" {
  description = "Lista de nomes dos ambientes do Apigee criados."
  value       = module.apigee.apigee_environment_names
}

output "apigee_envgroup_names" {
  description = "Lista de nomes dos EnvGroups do Apigee criados."
  value       = module.apigee.apigee_envgroup_names
}

output "apigee_envgroup_hostnames" {
  description = "Mapa de EnvGroups e seus hostnames configurados."
  value       = module.apigee.apigee_envgroup_hostnames
}

output "apigee_instance_service_attachment" {
  description = "Service attachment PSC da instância do Apigee."
  value       = module.apigee.apigee_instance_service_attachment
}
