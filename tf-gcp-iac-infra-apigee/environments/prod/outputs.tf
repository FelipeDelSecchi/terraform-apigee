output "apigee_org_id" {
  description = "ID da organização do Apigee criada."
  value       = module.apigee.apigee_org_id
}

output "apigee_instance_name" {
  description = "Nome da instância do Apigee criada."
  value       = module.apigee.apigee_instance_name
}

output "apigee_environment_name" {
  description = "Nome do ambiente do Apigee criado."
  value       = module.apigee.apigee_environment_name
}

output "apigee_envgroup_name" {
  description = "Nome do EnvGroup do Apigee criado."
  value       = module.apigee.apigee_envgroup_name
}

output "apigee_envgroup_hostnames" {
  description = "Lista de hostnames configurados no EnvGroup."
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
