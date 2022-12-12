resource "random_id" "this" {
  keepers = {
    namespace   = module.this.namespace
    tenant      = module.this.tenant
    environment = module.this.environment
    stage       = module.this.stage
    attributes  = join("", module.this.attributes)
  }

  byte_length = 3
}

module "resource_group" {
  source  = "getindata/resource-group/azurerm"
  version = "1.2.0"

  context = module.this.context

  name     = var.resource_group_name
  location = var.location
}

module "this_atlantis" {
  source = "../../modules/caddy-automatic-https"

  context = module.this.context

  name = "atlantis"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  attributes = [random_id.this.hex]

  atlantis_server_config     = var.atlantis_server_config
  atlantis_repo_config_repos = var.atlantis_repo_config_repos

  atlantis_container = {
    secure_environment_variables = var.atlantis_secure_environment_variables
  }

  dns_name_label = format("atlantis-%s", random_id.this.hex)
  identity = {
    enabled = true
  }
}
