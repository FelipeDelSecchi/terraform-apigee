variable "project_id" {
  description = "(Obrigatório) ID do projeto GCP onde os recursos do Apigee serão criados para este ambiente."
  type        = string
}

variable "region" {
  description = "(Obrigatório) Região padrão do provider Google (ex.: southamerica-east1)."
  type        = string
}

variable "analytics_region" {
  description = "(Obrigatório) Região para armazenamento dos dados de analytics do Apigee."
  type        = string
}

variable "runtime_location" {
  description = "(Obrigatório) Localização (região) onde a instância do Apigee será criada."
  type        = string
}

variable "apigee_org_display_name" {
  description = "(Opcional) Nome de exibição da organização do Apigee."
  type        = string
  default     = null
}

variable "apigee_billing_type" {
  description = "(Opcional) Tipo de cobrança do Apigee (ex.: PAYG ou EVALUATION)."
  type        = string
  default     = "PAYG"
}

variable "apigee_authorized_network" {
  description = "(Opcional) Self link da VPC autorizada a se comunicar com o serviço gerenciado do Apigee via PSC."
  type        = string
  default     = null
}

variable "apigee_environment_name" {
  description = "(Obrigatório) Nome do ambiente do Apigee (ex.: dev, hml, prod)."
  type        = string
}

variable "apigee_environment_display_name" {
  description = "(Opcional) Nome de exibição do ambiente do Apigee."
  type        = string
  default     = null
}

variable "apigee_environment_description" {
  description = "(Opcional) Descrição do ambiente do Apigee."
  type        = string
  default     = null
}

variable "apigee_envgroup_name" {
  description = "(Obrigatório) Nome do grupo de ambientes (EnvGroup) do Apigee."
  type        = string
}

variable "apigee_envgroup_hostnames" {
  description = "(Obrigatório) Lista de hostnames que serão expostos pelo EnvGroup."
  type        = list(string)
}

variable "labels" {
  description = "(Opcional) Conjunto de labels a serem aplicadas nos recursos quando suportado."
  type        = map(string)
  default     = {}
}

variable "create_external_https_load_balancer" {
  description = "(Opcional) Define se o Load Balancer HTTPS externo deve ser criado."
  type        = bool
  default     = true
}

variable "external_lb_name" {
  description = "(Opcional) Nome base do Load Balancer HTTPS externo."
  type        = string
  default     = "apigee-external-lb"
}

variable "external_lb_cert_domains" {
  description = "(Opcional) Lista de domínios que serão usados no certificado SSL gerenciado do Load Balancer."
  type        = list(string)
  default     = []
}

variable "psc_neg_region" {
  description = "(Opcional) Região do NEG de Private Service Connect que apontará para o serviço do Apigee."
  type        = string
  default     = null
}

variable "psc_neg_network" {
  description = "(Opcional) Self link da VPC onde o NEG de PSC será criado."
  type        = string
  default     = null
}

variable "psc_neg_subnetwork" {
  description = "(Opcional) Self link da sub-rede onde o NEG de PSC será criado."
  type        = string
  default     = null
}

variable "psc_target_service" {
  description = "(Opcional) Service attachment de Private Service Connect exposto pelo Apigee."
  type        = string
  default     = null
}
