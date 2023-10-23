data "azurerm_resource_group" "this" {
  count = module.this.enabled && var.location == null ? 1 : 0

  name = var.resource_group_name
}

module "caddy_persistence_storage_account" {
  source  = "getindata/storage-account/azurerm"
  version = "1.7.1"
  context = module.this.context

  enabled = var.caddy_persistence_storage_account == null

  attributes          = ["caddy"]
  resource_group_name = local.resource_group_name

  file_shares = [{
    name  = "caddy"
    quota = 1
  }]
}

module "this_atlantis" {
  source  = "../../"
  context = module.this.context

  resource_group_name = local.resource_group_name
  location            = local.location

  descriptor_name = var.descriptor_name

  diagnostic_settings = var.diagnostic_settings

  #Atlantis specific variables
  atlantis_container = merge(var.atlantis_container, {
    environment_variables = local.atlantis_environment_variables
  })

  atlantis_server_config                   = var.atlantis_server_config
  atlantis_repo_config_repos               = var.atlantis_repo_config_repos
  atlantis_repo_config_repos_common_config = var.atlantis_repo_config_repos_common_config
  atlantis_repo_config_workflows           = var.atlantis_repo_config_workflows
  atlantis_repo_config_file                = var.atlantis_repo_config_file

  #Container groups variables
  containers                          = merge({ caddy = local.caddy_container }, var.containers)
  subnet_ids                          = var.subnet_ids
  dns_name_label                      = var.dns_name_label
  dns_name_servers                    = var.dns_name_servers
  exposed_ports                       = var.exposed_ports
  restart_policy                      = var.restart_policy
  identity                            = var.identity
  image_registry_credential           = var.image_registry_credential
  container_diagnostics_log_analytics = var.container_diagnostics_log_analytics
}
