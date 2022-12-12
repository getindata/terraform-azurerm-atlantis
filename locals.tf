locals {
  atlantis_environment_variables_from_terraform_config = { for k in keys(var.atlantis_server_config) :
  "ATLANTIS_${upper(replace(k, "-", "_"))}" => var.atlantis_server_config[k] }
  atlantis_environment_variables_msi = merge(
    var.identity != null ? { ARM_USE_MSI = "true" } : {},
    try(length(var.identity.system_assigned_identity_role_assignments), 0) > 0 ? { ARM_CLIENT_ID = one(var.identity.system_assigned_identity_role_assignments) } : {},
  )
  atlantis_environment_variables = merge(
    local.atlantis_environment_variables_msi,
    local.atlantis_environment_variables_from_terraform_config,
    { ATLANTIS_REPO_CONFIG_JSON = coalesce(
      lookup(local.atlantis_environment_variables_from_terraform_config, "ATLANTIS_REPO_CONFIG_JSON", null),
      module.atlantis_repo_config.repos_config_json
    ) },
    var.atlantis_container.environment_variables
  )
}
