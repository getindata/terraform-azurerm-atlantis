variable "resource_group_name" {
  description = "Azure resource group name where resources will be deployed"
  type        = string
}

variable "location" {
  description = "Location where resources will be deployed. If not provided it will be read from resource group location"
  type        = string
  default     = null
}

variable "descriptor_name" {
  description = "Name of the descriptor used to form a resource name"
  type        = string
  default     = "azure-container-group"
}

variable "diagnostic_settings" {
  description = "Enables diagnostics settings for a resource and streams the logs and metrics to any provided sinks"
  type = object({
    enabled               = optional(bool, false)
    logs_destinations_ids = optional(list(string), [])
  })
  default = {}
}

variable "atlantis_container" {
  description = "Atlantis container configuration. First item of the ports list must refer to the Atlantis"
  type = object({
    image  = optional(string, "ghcr.io/runatlantis/atlantis")
    cpu    = optional(number, 1)
    memory = optional(number, 1)
    ports = optional(list(object({
      port     = number
      protocol = optional(string, "TCP")
      })), [{
      port     = 4141
      protocol = "TCP"
    }])
    commands                     = optional(list(string), ["atlantis", "server"])
    environment_variables        = optional(map(string), {})
    secure_environment_variables = optional(map(string), {})
    secure_environment_variables_from_key_vault = optional(map(object({
      key_vault_id = string
      name         = string
    })), {})
    volumes = optional(map(object({
      mount_path = string
      read_only  = optional(bool, false)
      empty_dir  = optional(bool)
      git_repo = optional(object({
        url       = string
        directory = optional(string)
        revision  = optional(string)
      }))
      secret               = optional(map(string))
      storage_account_name = optional(string)
      storage_account_key  = optional(string)
      share_name           = optional(string)
    })), {})
  })
  default = {}
}

variable "atlantis_server_config" {
  description = "Atlantis server config. If any option is not available here, it can be passed by `environment_variables` variable"
  type = object({
    allow_draft_prs                 = optional(string)
    allow_fork_prs                  = optional(string)
    allow_repo_config               = optional(string)
    atlantis_url                    = optional(string)
    automerge                       = optional(string)
    autoplan_file_list              = optional(string)
    autoplan_modules                = optional(string)
    autoplan_modules_from_projects  = optional(string)
    azuredevops_hostname            = optional(string)
    azuredevops_webhook_password    = optional(string)
    azuredevops_webhook_user        = optional(string)
    azuredevops_token               = optional(string)
    azuredevops_user                = optional(string)
    bitbucket_base_url              = optional(string)
    bitbucket_token                 = optional(string)
    bitbucket_user                  = optional(string)
    bitbucket_webhook_secret        = optional(string)
    checkout_strategy               = optional(string)
    config                          = optional(string)
    data_dir                        = optional(string)
    default_tf_version              = optional(string)
    disable_apply                   = optional(string)
    disable_apply_all               = optional(string)
    disable_autoplan                = optional(string)
    disable_markdown_folding        = optional(string)
    disable_repo_locking            = optional(string)
    enable_policy_checks            = optional(string)
    enable_regexp_cmd               = optional(string)
    enable_diff_markdown_format     = optional(string)
    gh_hostname                     = optional(string)
    gh_token                        = optional(string)
    gh_user                         = optional(string)
    gh_webhook_secret               = optional(string)
    gh_org                          = optional(string)
    gh_app_id                       = optional(string)
    gh_app_slug                     = optional(string)
    gh_app_key_file                 = optional(string)
    gh_app_key                      = optional(string)
    gh_team_allowlist               = optional(string)
    gh_allow_mergeable_bypass_apply = optional(string)
    gitlab_hostname                 = optional(string)
    gitlab_token                    = optional(string)
    gitlab_user                     = optional(string)
    gitlab_webhook_secret           = optional(string)
    help                            = optional(string)
    hide_prev_plan_comments         = optional(string)
    locking_db_type                 = optional(string)
    log_level                       = optional(string)
    markdown_template_overrides_dir = optional(string)
    parallel_pool_size              = optional(string)
    port                            = optional(string)
    quiet_policy_checks             = optional(string)
    redis_host                      = optional(string)
    redis_password                  = optional(string)
    redis_port                      = optional(string)
    redis_db                        = optional(string)
    redis_tls_enabled               = optional(string)
    redis_insecure_skip_verify      = optional(string)
    repo_config                     = optional(string)
    repo_config_json                = optional(string)
    repo_whitelist                  = optional(string)
    repo_allowlist                  = optional(string)
    require_approval                = optional(string)
    require_mergeable               = optional(string)
    silence_fork_pr_errors          = optional(string)
    silence_whitelist_errors        = optional(string)
    silence_allowlist_errors        = optional(string)
    silence_no_projects             = optional(string)
    silence_vcs_status_no_plans     = optional(string)
    skip_clone_no_changes           = optional(string)
    slack_token                     = optional(string)
    ssl_cert_file                   = optional(string)
    ssl_key_file                    = optional(string)
    stats_namespace                 = optional(string)
    tf_download_url                 = optional(string)
    tfe_hostname                    = optional(string)
    tfe_local_execution_mode        = optional(string)
    tfe_token                       = optional(string)
    var_file_allowlist              = optional(string)
    vcs_status_name                 = optional(string)
    write_git_creds                 = optional(string)
    web_basic_auth                  = optional(bool)
    web_username                    = optional(string)
    web_password                    = optional(string)
    websocket_check_origin          = optional(string)
  })
  default = {}
}

###########################################
## Atlantis Repos config                 ##
###########################################

variable "atlantis_repo_config_repos" {
  description = "Map of repositories and their configs. Refer to https://www.runatlantis.io/docs/server-side-repo-config.html#example-server-side-repo"
  type = list(object({
    id                            = optional(string, "/.*/")
    branch                        = optional(string)
    apply_requirements            = optional(list(string))
    allowed_overrides             = optional(list(string))
    allowed_workflows             = optional(list(string))
    allow_custom_workflows        = optional(bool)
    delete_source_branch_on_merge = optional(bool)
    pre_workflow_hooks = optional(list(object({
      run = string
    })))
    post_workflow_hooks = optional(list(object({
      run = string
    })))
    workflow = optional(string)
    ######### Helpers #########
    allow_all_server_side_workflows = optional(bool, false)
    terragrunt_atlantis_config = optional(object({
      enabled              = optional(bool, false)
      output               = optional(string, "atlantis.yaml")
      automerge            = optional(bool)
      autoplan             = optional(bool)
      parallel             = optional(bool)
      cascade_dependencies = optional(bool)
      filter               = optional(string)
      use_project_markers  = optional(bool)
    }), {})
  }))
  default = []
}

variable "atlantis_repo_config_repos_common_config" {
  description = "Common config that will be merged into each item of the repos list"
  type = object({
    id                            = optional(string)
    branch                        = optional(string)
    apply_requirements            = optional(list(string))
    allowed_overrides             = optional(list(string))
    allowed_workflows             = optional(list(string))
    allow_custom_workflows        = optional(bool)
    delete_source_branch_on_merge = optional(bool)
    pre_workflow_hooks = optional(list(object({
      run = string
    })))
    post_workflow_hooks = optional(list(object({
      run = string
    })))
    workflow = optional(string)
    ######### Helpers #########
    allow_all_server_side_workflows = optional(bool, false)
    terragrunt_atlantis_config = optional(object({
      enabled  = optional(bool, false)
      output   = optional(string, "atlantis.yaml")
      autoplan = optional(bool, false)
      parallel = optional(bool, false)
      filter   = optional(string)
    }), {})
  })
  default = {}
}

variable "atlantis_repo_config_workflows" {
  description = "List of custom workflow that will be added to the repo config file"
  type = map(object({
    plan = optional(object({
      steps = any
    }))
    apply = optional(object({
      steps = any
    }))
    policy_check = optional(object({
      steps = any
    }))
  }))
  default = {}
}

variable "atlantis_repo_config_use_predefined_workflows" {
  description = "Indicates wherever predefined workflows should be added to the generated repo config file"
  type        = bool
  default     = true
}

variable "atlantis_repo_config_file" {
  description = "Configures config file generation if enabled"
  type = object({
    enabled = optional(bool, false)
    path    = optional(string, ".")
    name    = optional(string, "repo_config.yaml")
    format  = optional(string, "yaml")
  })
  default = {}

  validation {
    condition     = contains(["yaml", "json"], var.atlantis_repo_config_file.format)
    error_message = "Invalid format provided. Allowed values: yaml, json"
  }
}

###########################################
## Rest of Azure Container Group Configs ##
###########################################

variable "containers" {
  description = "List of containers that will be running in the container group"
  type = map(object({
    image  = string
    cpu    = number
    memory = number
    ports = optional(list(object({
      port     = number
      protocol = optional(string, "TCP")
    })), [])
    commands                     = optional(list(string), [])
    environment_variables        = optional(map(string), {})
    secure_environment_variables = optional(map(string), {})
    secure_environment_variables_from_key_vault = optional(map(object({
      key_vault_id = string
      name         = string
    })), {})
    volumes = optional(map(object({
      mount_path = string
      read_only  = optional(bool, false)
      empty_dir  = optional(bool)
      git_repo = optional(object({
        url       = string
        directory = optional(string)
        revision  = optional(string)
      }))
      secret               = optional(map(string))
      storage_account_name = optional(string)
      storage_account_key  = optional(string)
      share_name           = optional(string)
    })), {})
  }))
  default = {}
}

variable "exposed_ports" {
  description = "It can only contain ports that are also exposed on one or more containers in the group"
  type = list(object({
    port     = number
    protocol = optional(string, "TCP")
  }))
  default = []
}

variable "subnet_ids" {
  description = "The subnet resource IDs for a container group. At the moment it supports 1 subnet maximum"
  type        = list(string)
  default     = []
}

variable "dns_name_label" {
  description = "The DNS label/name for the container group's IP. If not provided it will use the name of the resource"
  type        = string
  default     = null
}

variable "dns_name_servers" {
  description = "DNS name servers configured with containers"
  type        = list(string)
  default     = []
}

variable "restart_policy" {
  description = "Restart policy for the container group. Allowed values are `Always`, `Never`, `OnFailure`. Defaults to `Always`"
  type        = string
  default     = "Always"

  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "Allowed values are `Always`, `Never` or `OnFailure`"
  }
}

variable "identity" {
  description = "Managed identity block. For type possible values are: SystemAssigned and UserAssigned"
  type = object({
    enabled      = optional(bool, false)
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string), [])
    user_assigned_identity = optional(object({
      enabled         = optional(bool, false)
      descriptor_name = optional(string, "azure-managed-service-identity")
    }), {})
    role_assignments = optional(list(object({
      scope                = string
      role_definition_name = string
    })), [])
  })
}

variable "image_registry_credential" {
  description = "Credentials for ACR, so the images can be pulled by the container instance"
  type = list(object({
    username = string
    password = string
    server   = string
  }))
  default = []
}

variable "container_diagnostics_log_analytics" {
  description = "Log Analytics workspace to be used with container logs"
  type = object({
    workspace_id  = string
    workspace_key = string
    log_type      = optional(string, "ContainerInsights")
  })
  default = null
}
