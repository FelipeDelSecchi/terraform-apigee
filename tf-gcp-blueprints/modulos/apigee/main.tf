locals {
  apigee_org_display_name = coalesce(var.apigee_org_display_name, var.project_id)

  # Mapa com todos os pares EnvGroup x Environment
  # Exemplo:
  # {
  #   "dev-envgroup-dev" = { envgroup = "dev-envgroup", env = "dev" }
  #   "hom-envgroup-hom" = { envgroup = "hom-envgroup", env = "hom" }
  # }
  apigee_envgroup_env_pairs = {
    for pair in flatten([
      for eg_name, eg in var.apigee_envgroups : [
        for env_name in eg.environments : {
          key      = "${eg_name}-${env_name}"
          envgroup = eg_name
          env      = env_name
        }
      ]
    ]) : pair.key => {
      envgroup = pair.envgroup
      env      = pair.env
    }
  }
}

# Organização do Apigee
resource "google_apigee_organization" "this" {
  project_id         = var.project_id
  display_name       = local.apigee_org_display_name
  analytics_region   = var.apigee_analytics_region
  billing_type       = var.apigee_billing_type
  authorized_network = var.apigee_authorized_network
}

# Instância do Apigee
resource "google_apigee_instance" "this" {
  name     = "apigee-instance"
  org_id   = google_apigee_organization.this.id
  ip_range = var.apigee_ip_range
  location = var.apigee_runtime_location
}

# Ambientes do Apigee (multi-env)
resource "google_apigee_environment" "this" {
  for_each = var.apigee_environments

  org_id       = google_apigee_organization.this.id
  name         = each.key
  display_name = coalesce(try(each.value.display_name, null), each.key)
  description  = try(each.value.description, null)
}

# Anexar ambientes à instância
resource "google_apigee_instance_attachment" "this" {
  for_each    = google_apigee_environment.this
  instance_id = google_apigee_instance.this.id
  environment = each.value.name
}

# EnvGroups do Apigee (multi-envgroup)
resource "google_apigee_envgroup" "this" {
  for_each = var.apigee_envgroups

  org_id    = google_apigee_organization.this.id
  name      = each.key
  hostnames = each.value.hostnames
}

# Anexar EnvGroups aos ambientes configurados
resource "google_apigee_envgroup_attachment" "this" {
  # Um attachment para cada par EnvGroup x Ambiente definido em var.apigee_envgroups
  for_each = local.apigee_envgroup_env_pairs

  envgroup_id = google_apigee_envgroup.this[each.value.envgroup].id
  environment = google_apigee_environment.this[each.value.env].name
}