output "external_lb_ip_address" {
  description = "Endereço IP global do Load Balancer HTTPS externo."
  value       = module.apigee_lb.external_lb_ip_address
}

output "external_lb_name" {
  description = "Nome base do Load Balancer HTTPS externo."
  value       = module.apigee_lb.external_lb_name
}
