# Complete Example

```terraform
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
  source  = "../../"

  context = module.this.context

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  attributes = [random_id.this.hex]

  atlantis_server_config = var.atlantis_server_config
  atlantis_repo_config   = var.atlantis_repo_config

  secure_environment_variables = var.secure_environment_variables

  identity = {}
}
```

## Usage

1. Create `terraform.tfvars` file
2. Populate it with:
   ```terraform
   secure_environment_variables = {
     ATLANTIS_GITLAB_TOKEN          = "glpat-jWEhwGYABjHQY-Z7D3up"
     ATLANTIS_GITLAB_USER           = "jakubigla-getindata"
     ATLANTIS_GITLAB_WEBHOOK_SECRET = "1234"
   }
   ```
3. Run the commands from below:
    ```
    terraform init
    terraform plan -var-file fixtures.west-europe.tfvars -out tf.plan
    terraform apply tf.plan
    ```
