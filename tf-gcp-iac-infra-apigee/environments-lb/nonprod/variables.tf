variable "project_id" {
  description = "ID do projeto GCP onde o Load Balancer será criado."
  type        = string
}

variable "region" {
  description = "Região padrão do provider Google (ex.: us-central1)."
  type        = string
}

variable "labels" {
  description = "Labels para os recursos do LB."
  type        = map(string)
  default     = {}
}

variable "external_lb_name" {
  description = "Nome base do Load Balancer HTTPS externo."
  type        = string
}

variable "external_lb_cert_domains" {
  description = "Lista de domínios usados no certificado SSL gerenciado."
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
  description = "Service attachment PSC do Apigee (output do stack de Apigee)."
  type        = string
}
