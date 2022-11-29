# Atlantis in Azure Container Group Terraform Module
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

<!--- Replace repository name -->
![License](https://badgen.net/github/license/getindata/terraform-azurerm-atlantis/)
![Release](https://badgen.net/github/release/getindata/terraform-azurerm-atlantis/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

Terraform Module for deploying [Atlantis](https://www.runatlantis.io/) in Azure Container Group instance.

This module takes advantage of [terraform-null-atlantis-repo-config](https://github.com/getindata/terraform-null-atlantis-repo-config/),
which supplies a set of predefined custom workflows that are ready to use. 

## USAGE

```terraform
module "atlantis" {
  source = "github.com/getindata/terraform-azurerm-atlantis"

  resource_group_name = "example-rg"
  
  atlantis_server_config = {
    repo_allowlist = "github.com/getindata/*"
  }

  repo_config_repos = [
    {
      id                     = "/.*/"
      allowed_overrides      = ["workflow", "apply_requirements", "delete_source_branch_on_merge"]
      allow_custom_workflows = true
    }
  ]
}
```

## EXAMPLES

- [Complete example](examples/complete)

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_atlantis_server_config"></a> [atlantis\_server\_config](#input\_atlantis\_server\_config) | Atlantis server config. If any option is not available here, it can be passed by `environment_variables` variable | <pre>object({<br>    allow_draft_prs                 = optional(string)<br>    allow_fork_prs                  = optional(string)<br>    allow_repo_config               = optional(string)<br>    atlantis_url                    = optional(string)<br>    automerge                       = optional(string)<br>    autoplan_file_list              = optional(string)<br>    autoplan_modules                = optional(string)<br>    autoplan_modules_from_projects  = optional(string)<br>    azuredevops_hostname            = optional(string)<br>    azuredevops_webhook_password    = optional(string)<br>    azuredevops_webhook_user        = optional(string)<br>    azuredevops_token               = optional(string)<br>    azuredevops_user                = optional(string)<br>    bitbucket_base_url              = optional(string)<br>    bitbucket_token                 = optional(string)<br>    bitbucket_user                  = optional(string)<br>    bitbucket_webhook_secret        = optional(string)<br>    checkout_strategy               = optional(string)<br>    config                          = optional(string)<br>    data_dir                        = optional(string)<br>    default_tf_version              = optional(string)<br>    disable_apply                   = optional(string)<br>    disable_apply_all               = optional(string)<br>    disable_autoplan                = optional(string)<br>    disable_markdown_folding        = optional(string)<br>    disable_repo_locking            = optional(string)<br>    enable_policy_checks            = optional(string)<br>    enable_regexp_cmd               = optional(string)<br>    enable_diff_markdown_format     = optional(string)<br>    gh_hostname                     = optional(string)<br>    gh_token                        = optional(string)<br>    gh_user                         = optional(string)<br>    gh_webhook_secret               = optional(string)<br>    gh_org                          = optional(string)<br>    gh_app_id                       = optional(string)<br>    gh_app_slug                     = optional(string)<br>    gh_app_key_file                 = optional(string)<br>    gh_app_key                      = optional(string)<br>    gh_team_allowlist               = optional(string)<br>    gh_allow_mergeable_bypass_apply = optional(string)<br>    gitlab_hostname                 = optional(string)<br>    gitlab_token                    = optional(string)<br>    gitlab_user                     = optional(string)<br>    gitlab_webhook_secret           = optional(string)<br>    help                            = optional(string)<br>    hide_prev_plan_comments         = optional(string)<br>    locking_db_type                 = optional(string)<br>    log_level                       = optional(string)<br>    markdown_template_overrides_dir = optional(string)<br>    parallel_pool_size              = optional(string)<br>    port                            = optional(string)<br>    quiet_policy_checks             = optional(string)<br>    redis_host                      = optional(string)<br>    redis_password                  = optional(string)<br>    redis_port                      = optional(string)<br>    redis_db                        = optional(string)<br>    redis_tls_enabled               = optional(string)<br>    redis_insecure_skip_verify      = optional(string)<br>    repo_config                     = optional(string)<br>    repo_config_json                = optional(string)<br>    repo_whitelist                  = optional(string)<br>    repo_allowlist                  = optional(string)<br>    require_approval                = optional(string)<br>    require_mergeable               = optional(string)<br>    silence_fork_pr_errors          = optional(string)<br>    silence_whitelist_errors        = optional(string)<br>    silence_allowlist_errors        = optional(string)<br>    silence_no_projects             = optional(string)<br>    silence_vcs_status_no_plans     = optional(string)<br>    skip_clone_no_changes           = optional(string)<br>    slack_token                     = optional(string)<br>    ssl_cert_file                   = optional(string)<br>    ssl_key_file                    = optional(string)<br>    stats_namespace                 = optional(string)<br>    tf_download_url                 = optional(string)<br>    tfe_hostname                    = optional(string)<br>    tfe_local_execution_mode        = optional(string)<br>    tfe_token                       = optional(string)<br>    var_file_allowlist              = optional(string)<br>    vcs_status_name                 = optional(string)<br>    write_git_creds                 = optional(string)<br>    web_basic_auth                  = optional(string)<br>    web_username                    = optional(string)<br>    web_password                    = optional(string)<br>    websocket_check_origin          = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_container_diagnostics_log_analytics"></a> [container\_diagnostics\_log\_analytics](#input\_container\_diagnostics\_log\_analytics) | Log Analytics workspace to be used with container logs | <pre>object({<br>    workspace_id  = string<br>    workspace_key = string<br>    log_type      = optional(string, "ContainerInsights")<br>  })</pre> | `null` | no |
| <a name="input_container_group_diagnostics_setting"></a> [container\_group\_diagnostics\_setting](#input\_container\_group\_diagnostics\_setting) | Azure Monitor diagnostics for container group resource | <pre>object({<br>    workspace_resource_id = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The required number of CPU cores of the Atlantis container | `number` | `1` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_dns_name_label"></a> [dns\_name\_label](#input\_dns\_name\_label) | The DNS label/name for the container group's IP. If not provided it will use the name of the resource | `string` | `null` | no |
| <a name="input_dns_name_servers"></a> [dns\_name\_servers](#input\_dns\_name\_servers) | DNS name servers configured with containers | `list(string)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A list of environment variables to be set on the container | `map(string)` | `{}` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity block. For type possible values are: SystemAssigned and UserAssigned | <pre>object({<br>    type         = optional(string, "SystemAssigned")<br>    identity_ids = optional(list(string), [])<br>    system_assigned_identity_role_assignments = optional(list(object({<br>      scope                = string<br>      role_definition_name = string<br>    })), [])<br>  })</pre> | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | Container image with Atlantis | `string` | `"ghcr.io/runatlantis/atlantis"` | no |
| <a name="input_image_registry_credential"></a> [image\_registry\_credential](#input\_image\_registry\_credential) | Credentials for ACR, so the images can be pulled by the container instance | <pre>list(object({<br>    username = string<br>    password = string<br>    server   = string<br>  }))</pre> | `[]` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Location where resources will be deployed. If not provided it will be read from resource group location | `string` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The required memory of the Atlantis container in GB | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | Port on which Atlantis is listening | `number` | `4141` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_repo_config_file"></a> [repo\_config\_file](#input\_repo\_config\_file) | Configures config file generation if enabled | <pre>object({<br>    enabled = optional(bool, false)<br>    path    = optional(string, ".")<br>    name    = optional(string, "repo_config.yaml")<br>    format  = optional(string, "yaml")<br>  })</pre> | `{}` | no |
| <a name="input_repo_config_repos"></a> [repo\_config\_repos](#input\_repo\_config\_repos) | Map of repositories and their configs. Refer to https://www.runatlantis.io/docs/server-side-repo-config.html#example-server-side-repo | <pre>list(object({<br>    id                            = optional(string, "/.*/")<br>    branch                        = optional(string)<br>    apply_requirements            = optional(list(string))<br>    allowed_overrides             = optional(list(string))<br>    allowed_workflows             = optional(list(string))<br>    allow_custom_workflows        = optional(bool)<br>    delete_source_branch_on_merge = optional(bool)<br>    pre_workflow_hooks = optional(list(object({<br>      run = string<br>    })))<br>    post_workflow_hooks = optional(list(object({<br>      run = string<br>    })))<br>    workflow = optional(string)<br>    ######### Helpers #########<br>    allow_all_server_side_workflows = optional(bool, false)<br>    terragrunt_atlantis_config = optional(object({<br>      enabled              = optional(bool, false)<br>      output               = optional(string, "atlantis.yaml")<br>      automerge            = optional(bool)<br>      autoplan             = optional(bool)<br>      parallel             = optional(bool)<br>      cascade_dependencies = optional(bool)<br>      filter               = optional(string)<br>      use_project_markers  = optional(bool)<br>    }), {})<br>  }))</pre> | `[]` | no |
| <a name="input_repo_config_repos_common_config"></a> [repo\_config\_repos\_common\_config](#input\_repo\_config\_repos\_common\_config) | Common config that will be merged into each item of the repos list | <pre>object({<br>    id                            = optional(string)<br>    branch                        = optional(string)<br>    apply_requirements            = optional(list(string))<br>    allowed_overrides             = optional(list(string))<br>    allowed_workflows             = optional(list(string))<br>    allow_custom_workflows        = optional(bool)<br>    delete_source_branch_on_merge = optional(bool)<br>    pre_workflow_hooks = optional(list(object({<br>      run = string<br>    })))<br>    post_workflow_hooks = optional(list(object({<br>      run = string<br>    })))<br>    workflow = optional(string)<br>    ######### Helpers #########<br>    allow_all_server_side_workflows = optional(bool, false)<br>    terragrunt_atlantis_config = optional(object({<br>      enabled  = optional(bool, false)<br>      output   = optional(string, "atlantis.yaml")<br>      autoplan = optional(bool, false)<br>      parallel = optional(bool, false)<br>      filter   = optional(string)<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_repo_config_use_predefined_workflows"></a> [repo\_config\_use\_predefined\_workflows](#input\_repo\_config\_use\_predefined\_workflows) | Indicates wherever predefined workflows should be added to the generated repo config file | `bool` | `true` | no |
| <a name="input_repo_config_workflows"></a> [repo\_config\_workflows](#input\_repo\_config\_workflows) | List of custom workflow that will be added to the repo config file | <pre>map(object({<br>    plan = optional(object({<br>      steps = any<br>    }))<br>    apply = optional(object({<br>      steps = any<br>    }))<br>    policy_check = optional(object({<br>      steps = any<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azure resource group name where resources will be deployed | `string` | n/a | yes |
| <a name="input_secure_environment_variables"></a> [secure\_environment\_variables](#input\_secure\_environment\_variables) | A list of sensitive environment variables to be set on the container | `map(string)` | `{}` | no |
| <a name="input_secure_environment_variables_from_key_vault"></a> [secure\_environment\_variables\_from\_key\_vault](#input\_secure\_environment\_variables\_from\_key\_vault) | A list of sensitive environment variables to be set on the container read from Azure Key Vault | <pre>map(object({<br>    key_vault_id = string<br>    name         = string<br>  }))</pre> | `{}` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet resource IDs for a container group. At the moment it supports 1 subnet maximum | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_atlantis_repo_config"></a> [atlantis\_repo\_config](#module\_atlantis\_repo\_config) | getindata/atlantis-repo-config/null | 1.1.0 |
| <a name="module_azure_container_group"></a> [azure\_container\_group](#module\_azure\_container\_group) | getindata/container-group/azurerm | 1.1.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_atlantis_webhook_url"></a> [atlantis\_webhook\_url](#output\_atlantis\_webhook\_url) | Url of the Atlantis webhook used by git platforms like GitLab or GitHub |
| <a name="output_container_group_id"></a> [container\_group\_id](#output\_container\_group\_id) | ID of the container group |
| <a name="output_container_group_name"></a> [container\_group\_name](#output\_container\_group\_name) | Name of the container group |

## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |

## Resources

No resources.
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<!--- Replace repository name -->
<a href="https://github.com/getindata/REPO_NAME/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-azurerm-atlantis" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
