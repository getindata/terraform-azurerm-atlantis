module "atlantis_repo_config" {
  source  = "getindata/atlantis-repo-config/null"
  version = "1.1.0"

  repos               = var.repo_config_repos
  repos_common_config = var.repo_config_repos_common_config

  workflows                = var.repo_config_workflows
  use_predefined_workflows = var.repo_config_use_predefined_workflows

  repo_config_file = var.repo_config_file
}

module "azure_container_group" {
  source  = "getindata/container-group/azurerm"
  version = "1.1.0"

  context = module.this.context

  resource_group_name = var.resource_group_name
  location            = var.location

  name = coalesce(var.name, "atlantis")

  containers = {
    atlantis = {
      image  = var.image
      cpu    = var.cpu
      memory = var.memory
      ports = [
        {
          port = var.port
        }
      ]
      commands                                    = ["atlantis", "server"]
      environment_variables                       = local.atlantis_environment_variables
      secure_environment_variables                = local.atlantis_secure_environment_variables
      secure_environment_variables_from_key_vault = var.secure_environment_variables_from_key_vault
    }
  }

  subnet_ids                          = var.subnet_ids
  dns_name_label                      = var.dns_name_label
  dns_name_servers                    = var.dns_name_servers
  identity                            = var.identity
  image_registry_credential           = var.image_registry_credential
  container_diagnostics_log_analytics = var.container_diagnostics_log_analytics
  container_group_diagnostics_setting = var.container_group_diagnostics_setting
}
