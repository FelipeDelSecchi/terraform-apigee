variable "project_id" {
  description = "ID do projeto GCP onde os recursos do Apigee serão criados."
  type        = string
}

variable "apigee_org_display_name" {
  description = "Nome de exibição da organização do Apigee."
  type        = string
  default     = null
}

variable "apigee_analytics_region" {
  description = "Região para armazenamento dos dados de analytics do Apigee (ex.: us-central1)."
  type        = string
}

variable "apigee_runtime_location" {
  description = "Localização da instância de runtime do Apigee (ex.: us-central1)."
  type        = string
}

variable "apigee_billing_type" {
  description = "Tipo de billing do Apigee (ex.: SUBSCRIPTION)."
  type        = string
}

variable "apigee_authorized_network" {
  description = "Self link da VPC autorizada para o Apigee (PSA)."
  type        = string
}

variable "apigee_ip_range" {
  description = "CIDR /22 que a instância Apigee vai usar dentro do PSA (ex.: 10.230.100.0/22)."
  type        = string
}

variable "apigee_environments" {
  description = "Mapa de ambientes do Apigee."
  type = map(object({
    display_name = optional(string)
    description  = optional(string)
  }))
}

variable "apigee_envgroups" {
  description = "Mapa de EnvGroups do Apigee."
  type = map(object({
    hostnames    = list(string)
    environments = list(string)
  }))
}

variable "labels" {
  description = "Labels opcionais para recursos relacionados ao Apigee (mantido para compatibilidade)."
  type        = map(string)
  default     = {}
}
