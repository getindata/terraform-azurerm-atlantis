namespace           = "getindata"
environment         = "example"
location            = "West Europe"
resource_group_name = "atlantis-example"

descriptor_formats = {
  resource-group = {
    labels = ["name"]
    format = "%v-rg"
  }
  azure-container-group = {
    labels = ["namespace", "environment", "stage", "name", "attributes"]
    format = "%v-%v-%v-%v-%v-aci"
  }
}

tags = {
  Terraform = "True"
}

atlantis_server_config = {
  repo_allowlist = "gitlab.com/getindata/*"
}

atlantis_repo_config_repos = [
  {
    id                     = "/.*/"
    allowed_overrides      = ["workflow", "apply_requirements", "delete_source_branch_on_merge"]
    allow_custom_workflows = true
  }
]
