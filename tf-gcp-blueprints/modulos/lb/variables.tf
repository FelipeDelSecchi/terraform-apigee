variable "external_lb_name" {
  description = "Nome base do Load Balancer HTTPS externo."
  type        = string
}

variable "external_lb_cert_domains" {
  description = "Lista de domínios utilizados no certificado SSL gerenciado."
  type        = list(string)
}

variable "psc_neg_region" {
  description = "Região do NEG de Private Service Connect."
  type        = string
}

variable "psc_neg_network" {
  description = "Self link da VPC usada pelo NEG de PSC."
  type        = string
}

variable "psc_neg_subnetwork" {
  description = "Self link da sub-rede usada pelo NEG de PSC."
  type        = string
}

variable "psc_target_service" {
  description = "Service attachment PSC do backend Apigee (projects/.../regions/.../serviceAttachments/...)."
  type        = string
}

variable "labels" {
  description = "Labels opcionais para recursos de infraestrutura (usado para habilitar logs, por exemplo)."
  type        = map(string)
  default     = {}
}
