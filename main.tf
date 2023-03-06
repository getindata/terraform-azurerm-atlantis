module "atlantis_repo_config" {
  source  = "getindata/atlantis-repo-config/null"
  version = "2.0.0"

  repos               = var.atlantis_repo_config_repos
  repos_common_config = var.atlantis_repo_config_repos_common_config

  workflows = var.atlantis_repo_config_workflows

  repo_config_file = var.atlantis_repo_config_file
}

module "azure_container_group" {
  source  = "getindata/container-group/azurerm"
  version = "3.1.1"

  context = module.this.context

  resource_group_name = var.resource_group_name
  location            = var.location

  name            = coalesce(var.name, "atlantis")
  descriptor_name = var.descriptor_name

  diagnostic_settings = var.diagnostic_settings

  containers = merge({
    atlantis = merge(var.atlantis_container, {
      environment_variables = local.atlantis_environment_variables
    })
  }, var.containers)

  subnet_ids                          = var.subnet_ids
  dns_name_label                      = var.dns_name_label
  dns_name_servers                    = var.dns_name_servers
  exposed_ports                       = var.exposed_ports
  restart_policy                      = var.restart_policy
  identity                            = var.identity
  image_registry_credential           = var.image_registry_credential
  container_diagnostics_log_analytics = var.container_diagnostics_log_analytics
}
