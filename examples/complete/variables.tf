variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "atlantis_server_config" {
  description = "Atlantis server config. If any option is not available here, it can be passed by `environment_variables` variable"
  type = object({
    repo_config_json = optional(string)
    repo_allowlist   = optional(string)
  })
  default = {}
}

variable "repo_config_repos" {
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

variable "secure_environment_variables" {
  description = "A list of sensitive environment variables to be set on the container"
  type        = map(string)
  default     = {}
}
