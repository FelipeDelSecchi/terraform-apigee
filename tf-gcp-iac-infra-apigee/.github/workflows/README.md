# Workflows de CI/CD para IaC do Apigee

Este diretório deve conter os workflows do GitHub Actions responsáveis por:

- Executar `terraform fmt`, `terraform validate` e `terraform plan` em pull requests;
- Executar `terraform apply` nas branches e ambientes aprovados, utilizando autenticação OIDC;
- Carregar os valores sensíveis a partir do Secret Manager (ex.: arquivo terraform.tfvars.json).

A estrutura e o conteúdo exato destes workflows serão definidos em conjunto com o time da Eneva.
