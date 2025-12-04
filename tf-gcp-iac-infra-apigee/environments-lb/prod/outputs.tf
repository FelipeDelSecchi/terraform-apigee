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

output "external_lb_ip_address" {
  description = "Endereço IP global do Load Balancer HTTPS externo (se criado)."
  value       = module.apigee.external_lb_ip_address
}

output "external_lb_name" {
  description = "Nome base do Load Balancer HTTPS externo."
  value       = module.apigee.external_lb_name
}
