variable "resource_group_name" {
  description = "Azure resource group name where resources will be deployed"
  type        = string
}

variable "location" {
  description = "Location where resources will be deployed. If not provided it will be read from resource group location"
  type        = string
  default     = null
}

variable "image" {
  description = "Container image with Atlantis"
  type        = string
  default     = "ghcr.io/runatlantis/atlantis"
}

variable "cpu" {
  description = "The required number of CPU cores of the Atlantis container"
  type        = number
  default     = 1
}

variable "memory" {
  description = "The required memory of the Atlantis container in GB"
  type        = number
  default     = 2
}

variable "port" {
  description = "Port on which Atlantis is listening"
  type        = number
  default     = 4141
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

###########################################
## Rest of Azure Container Group Configs ##
###########################################

variable "environment_variables" {
  description = "A list of environment variables to be set on the container"
  type        = map(string)
  default     = {}
}

variable "secure_environment_variables" {
  description = "A list of sensitive environment variables to be set on the container"
  type        = map(string)
  default     = {}
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

variable "identity" {
  description = "Managed identity block. For type possible values are: SystemAssigned and UserAssigned"
  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string), [])
    system_assigned_identity_role_assignments = optional(list(object({
      scope                = string
      role_definition_name = string
    })), [])
  })
  default = null
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

variable "container_group_diagnostics_setting" {
  description = "Azure Monitor diagnostics for container group resource"
  type = object({
    workspace_resource_id = optional(string)
  })
  default = null
}
