data "azurerm_resource_group" "this" {
  count = module.this.enabled && var.location == null ? 1 : 0

  name = var.resource_group_name
}

module "this_atlantis" {
  source  = "../../"
  context = module.this.context

  resource_group_name = local.resource_group_name
  location            = local.location

  containers    = merge(var.containers, { caddy = local.caddy_container })
  exposed_ports = var.exposed_ports

  #Atlantis specific variables
  atlantis_container                            = var.atlantis_container
  atlantis_server_config                        = var.atlantis_server_config
  atlantis_repo_config_repos                    = var.atlantis_repo_config_repos
  atlantis_repo_config_repos_common_config      = var.atlantis_repo_config_repos_common_config
  atlantis_repo_config_workflows                = var.atlantis_repo_config_workflows
  atlantis_repo_config_use_predefined_workflows = var.atlantis_repo_config_use_predefined_workflows
  atlantis_repo_config_file                     = var.atlantis_repo_config_file

  #Container groups variables

  subnet_ids       = var.subnet_ids
  dns_name_label   = var.dns_name_label
  dns_name_servers = var.dns_name_servers

  restart_policy                      = var.restart_policy
  identity                            = var.identity
  image_registry_credential           = var.image_registry_credential
  container_diagnostics_log_analytics = var.container_diagnostics_log_analytics
  container_group_diagnostics_setting = var.container_group_diagnostics_setting
}
