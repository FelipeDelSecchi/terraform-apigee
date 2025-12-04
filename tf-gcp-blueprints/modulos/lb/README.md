# Módulo Apigee (Organização, Ambientes, EnvGroups e Load Balancer Externo)

Este módulo provisiona os componentes principais do Apigee (organização, instância, múltiplos ambientes
e múltiplos EnvGroups) e, opcionalmente, um Load Balancer HTTPS externo utilizando Private Service Connect (PSC)
para expor o gateway de forma gerenciada.

## Requisitos

- Terraform >= 1.13.0
- Provider Google >= 6.49.2
- Projeto GCP previamente criado
- VPC e sub-rede para criação do NEG de PSC (quando `create_external_https_load_balancer = true`)

## Conceito de uso

- **Uma instância do Apigee por Organização**.
- **Vários ambientes** dentro da mesma Organização (por exemplo: `dev` e `hom` em uma org nonprod, `prod` em outra).
- **Vários EnvGroups**, cada um associado a um ou mais ambientes.

Exemplo típico:
- Org nonprod: ambientes `dev` e `hom`, EnvGroups `dev-envgroup` e `hom-envgroup`.
- Org prod: ambiente `prod`, EnvGroup `prod-envgroup`.

## Variáveis principais

Veja o arquivo `variables.tf` para a lista completa de variáveis.

Destacam-se:

- `project_id` (obrigatório)
- `apigee_analytics_region` (obrigatório)
- `apigee_runtime_location` (obrigatório)
- `apigee_environments` (obrigatório): mapa de ambientes.
- `apigee_envgroups` (obrigatório): mapa de EnvGroups e seus ambientes associados.
- `create_external_https_load_balancer` (opcional)
- `external_lb_cert_domains` (opcional)
- `psc_neg_region`, `psc_neg_network`, `psc_neg_subnetwork` (opcionais)
- `psc_target_service` (opcional; se omitido, usa o `service_attachment` da instância do Apigee).

## Exemplo de uso (org nonprod, com dev e hom)

```hcl
module "apigee" {
  source = "git::https://example.com/tf-gcp-blueprints.git//modulos/apigee?ref=v0.1.0"

  project_id              = var.project_id
  apigee_analytics_region = var.analytics_region
  apigee_runtime_location = var.runtime_location

  apigee_environments = {
    dev = {
      description = "Ambiente de desenvolvimento"
    }
    hom = {
      description = "Ambiente de homologação"
    }
  }

  apigee_envgroups = {
    dev-envgroup = {
      hostnames    = ["api-dev.minhaempresa.com.br"]
      environments = ["dev"]
    }
    hom-envgroup = {
      hostnames    = ["api-hom.minhaempresa.com.br"]
      environments = ["hom"]
    }
  }

  create_external_https_load_balancer = true
  external_lb_name                    = "apigee-nonprod-external-lb"
  external_lb_cert_domains            = ["api-dev.minhaempresa.com.br", "api-hom.minhaempresa.com.br"]
  psc_neg_region                      = var.psc_neg_region
  psc_neg_network                     = var.psc_neg_network
  psc_neg_subnetwork                  = var.psc_neg_subnetwork
}
```

A esteira de CI/CD pode utilizar um arquivo `terraform.tfvars.json` por ambiente (nonprod, prod),
armazenado no Secret Manager.
