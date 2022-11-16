variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist."
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

variable "atlantis_repo_config" {
  description = "Atlantis repo config. If will be provided as `repo_config_json` if `repo_config_json` is not explicitly provided"
  type = object({
    repos = optional(list(object({
      id                     = string
      allowed_overrides      = optional(list(string), [])
      allow_custom_workflows = optional(bool, false)
    })), [])
  })
  default = {}
}

variable "secure_environment_variables" {
  description = "A list of sensitive environment variables to be set on the container"
  type        = map(string)
  default     = {}
}
