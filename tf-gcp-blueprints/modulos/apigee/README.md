# Módulo Apigee (Organização, Ambiente e Load Balancer Externo)

Este módulo provisiona os componentes principais do Apigee (organização, instância, ambiente e EnvGroup)
e, opcionalmente, um Load Balancer HTTPS externo utilizando Private Service Connect (PSC) para expor o
gateway de forma gerenciada.

## Requisitos

- Terraform >= 1.13.0
- Provider Google >= 6.49.2
- Projeto GCP previamente criado
- VPC e sub-rede para criação do NEG de PSC (quando `create_external_https_load_balancer = true`)

## Entradas principais

Veja o arquivo `variables.tf` para a lista completa de variáveis, com descrição em português,
tipo e indicação se são obrigatórias ou opcionais.

Exemplos de variáveis obrigatórias:
- `project_id`
- `apigee_analytics_region`
- `apigee_runtime_location`
- `apigee_environment_name`
- `apigee_envgroup_name`
- `apigee_envgroup_hostnames`

## Saídas

- `apigee_org_id`
- `apigee_instance_name`
- `apigee_environment_name`
- `apigee_envgroup_name`
- `apigee_envgroup_hostnames`
- `external_lb_ip_address`
- `external_lb_name`

## Exemplo de uso

```hcl
module "apigee" {
  source = "git::https://example.com/tf-gcp-blueprints.git//modulos/apigee?ref=v0.1.0"

  project_id               = var.project_id
  apigee_analytics_region  = var.analytics_region
  apigee_runtime_location  = var.runtime_location
  apigee_environment_name  = var.apigee_environment_name
  apigee_envgroup_name     = var.apigee_envgroup_name
  apigee_envgroup_hostnames = var.apigee_envgroup_hostnames

  create_external_https_load_balancer = true
  external_lb_cert_domains            = var.external_lb_cert_domains
  psc_neg_region                      = var.psc_neg_region
  psc_neg_network                     = var.psc_neg_network
  psc_neg_subnetwork                  = var.psc_neg_subnetwork
  psc_target_service                  = var.psc_target_service
}
```

A esteira de CI/CD pode utilizar um arquivo `terraform.tfvars.json` armazenado no Secret Manager
para prover os valores de cada ambiente.
