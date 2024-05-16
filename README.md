# Azure Synapse Terraform Module

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

Dynamic Terraform Module to create Azure Synapse Workspace and all Related Resources.

## Table of Contents

* [Module versioning rule](README.md#module-versioning-rule)
* [Supported Features](README.md#supported-features)
* [How to Use](README.md#how-to-use)
    * [Basic](README.md#basic)
* [Examples](README.md#examples)
* [Requirements](README.md#requirements)
* [Providers](README.md#providers)
* [Modules](README.md#modules)
* [Resources](README.md#resources)
* [Inputs](README.md#inputs)
* [Outputs](README.md#outputs)
* [License](README.md#license)

## Module versioning rule

| Module version | Azure Provider version |
|----------------|------------------------|
| >= 1.x.x       | => 3.22                |

## Supported Features

- Synapse Workspace
- Synapse Role Assignments
- Synapse Firewall Rules
- Spark Pools
- Linked Services
- Azure Integration Runtime
- Self Hosted Integration Runtime
- Integration with Microsoft Purview

## How to Use

### Basic

```hcl
module "synapse" {
  source                               = "fdmsantos/synapse/azurerm"
  version                              = "x.x.x"
  name                                 = "synapse"
  resource_group_name                  = "<resource_group>"
  location                             = "<location>"
  storage_data_lake_gen2_filesystem_id = "<storage_data_lake_gen2_filesystem_id>"
  storage_account_id                   = "<storage_account_id>"
}
```

## Examples

- [complete](https://github.com/fdmsantos/terraform-azurerm-synapse/tree/main/examples/complete) - Creates Synapse Workspace with all supported features.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.22 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.22 |
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.4 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.storage_blob_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_synapse_firewall_rule.azureservices](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_firewall_rule.client_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_integration_runtime_azure.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_integration_runtime_azure) | resource |
| [azurerm_synapse_integration_runtime_self_hosted.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_integration_runtime_self_hosted) | resource |
| [azurerm_synapse_linked_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_linked_service) | resource |
| [azurerm_synapse_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_role_assignment) | resource |
| [azurerm_synapse_spark_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_spark_pool) | resource |
| [azurerm_synapse_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace) | resource |
| [random_password.sql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [http_http.client_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_admin"></a> [aad\_admin](#input\_aad\_admin) | Credentials of the Azure AD Administrator of this Synapse Workspace. | <pre>object({<br>    login     = string<br>    tenant_id = string<br>    object_id = string<br>  })</pre> | `null` | no |
| <a name="input_add_storage_contributor_role"></a> [add\_storage\_contributor\_role](#input\_add\_storage\_contributor\_role) | If true, add Storage Contributor Role to Synapse Workspace identity. | `bool` | `true` | no |
| <a name="input_allow_azure_services_access"></a> [allow\_azure\_services\_access](#input\_allow\_azure\_services\_access) | If true, allow Azure Services and Resources to access this workspace. | `bool` | `false` | no |
| <a name="input_allow_own_ip"></a> [allow\_own\_ip](#input\_allow\_own\_ip) | If true, create firewall rule to allow client IP to Synapse Workspace. | `bool` | `false` | no |
| <a name="input_auth_sql_administrator"></a> [auth\_sql\_administrator](#input\_auth\_sql\_administrator) | Specifies The login name of the SQL administrator. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_auth_sql_administrator_password"></a> [auth\_sql\_administrator\_password](#input\_auth\_sql\_administrator\_password) | The Password associated with the sql\_administrator\_login for the SQL administrator. | `string` | `null` | no |
| <a name="input_azure_integration_runtimes"></a> [azure\_integration\_runtimes](#input\_azure\_integration\_runtimes) | Manages a Azure Synapse Azure Integration Runtimes. | <pre>map(object({<br>    location         = optional(string, "AutoResolve")<br>    compute_type     = optional(string, "General")<br>    core_count       = optional(number, 8)<br>    description      = optional(string, null)<br>    time_to_live_min = optional(number, 0)<br>  }))</pre> | `{}` | no |
| <a name="input_azuread_authentication_only"></a> [azuread\_authentication\_only](#input\_azuread\_authentication\_only) | Azure Active Directory Authentication the only way to authenticate with resources inside this synapse Workspace. | `bool` | `false` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | Allows you to Manages a Synapse Firewall Rules. | <pre>list(object({<br>    name             = string<br>    start_ip_address = string<br>    end_ip_address   = string<br>  }))</pre> | `[]` | no |
| <a name="input_github"></a> [github](#input\_github) | Integrate Synapse Workspace with Github. | <pre>object({<br>    account_name    = string<br>    repository_name = string<br>    branch_name     = string<br>    root_folder     = string<br>    last_commit_id  = optional(string)<br>    git_url         = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Synapse Workspace. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Specifies the type of Managed Service Identity that should be associated with this Logic App. | `string` | `null` | no |
| <a name="input_linked_services"></a> [linked\_services](#input\_linked\_services) | Manages a Synapse Linked Services. | <pre>map(object({<br>    type                           = string<br>    type_properties_json           = string<br>    additional_properties          = optional(map(string), {})<br>    annotations                    = optional(list(string), [])<br>    description                    = optional(string, null)<br>    parameters                     = optional(map(string), {})<br>    integration_runtime_name       = optional(string, null)<br>    integration_runtime_parameters = optional(map(string), {})<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the Azure Region where the synapse Workspace should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name which should be used for this synapse Workspace. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_purview_id"></a> [purview\_id](#input\_purview\_id) | The ID of purview account. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the Resource Group where the synapse Workspace should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_self_hosted_integration_runtimes"></a> [self\_hosted\_integration\_runtimes](#input\_self\_hosted\_integration\_runtimes) | Manages a Self Hosted Synapse Azure Integration Runtimes. | <pre>map(object({<br>    description = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_spark_pools"></a> [spark\_pools](#input\_spark\_pools) | Manages a Synapse Spark Pools. | <pre>map(object({<br>    node_size_family                    = optional(string, "None")<br>    node_size                           = optional(string, "Small")<br>    node_count                          = optional(number, null)<br>    cache_size                          = optional(number, null)<br>    compute_isolation_enabled           = optional(bool, false)<br>    dynamic_executor_allocation_enabled = optional(bool, false)<br>    min_executors                       = optional(number, null)<br>    max_executors                       = optional(number, null)<br>    session_level_packages_enabled      = optional(bool, false)<br>    spark_log_folder                    = optional(string, "/logs")<br>    spark_events_folder                 = optional(string, "/events")<br>    spark_version                       = optional(string, "3.4")<br>    autoscale_max_node_count            = optional(number, null)<br>    autoscale_min_node_count            = optional(number, null)<br>    autopause_delay_in_minutes          = optional(number, null)<br>    requirements_content                = optional(string, null)<br>    requirements_filename               = optional(string, "requirements.txt")<br>    spark_config_content                = optional(string, null)<br>    spark_config_filename               = optional(string, "config.txt")<br>  }))</pre> | `{}` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | Storage Account ID used by Synapse Workspace. Necessary if `add_storage_contributor_role` is true. | `string` | `false` | no |
| <a name="input_storage_data_lake_gen2_filesystem_id"></a> [storage\_data\_lake\_gen2\_filesystem\_id](#input\_storage\_data\_lake\_gen2\_filesystem\_id) | Specifies the ID of storage data lake gen2 filesystem resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_synapse_role_assignments"></a> [synapse\_role\_assignments](#input\_synapse\_role\_assignments) | Manages a Synapse Role Assignment. | <pre>list(object({<br>    role_name      = string<br>    principal_id   = string<br>    principal_type = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to the Synapse Workspace. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_integration_runtimes_id"></a> [azure\_integration\_runtimes\_id](#output\_azure\_integration\_runtimes\_id) | The Azure Integration Runtimes ID. |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | A list of Connectivity endpoints for this Synapse Workspace. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the synapse Workspace. |
| <a name="output_identity"></a> [identity](#output\_identity) | The Principal ID and Tenant ID for the Service Principal associated with the Managed Service Identity of this Synapse Workspace. |
| <a name="output_linked_services_id"></a> [linked\_services\_id](#output\_linked\_services\_id) | The Linked Services ID. |
| <a name="output_self_hosted_integration_runtimes_id"></a> [self\_hosted\_integration\_runtimes\_id](#output\_self\_hosted\_integration\_runtimes\_id) | The Self Hosted Integration Runtimes ID. |
| <a name="output_spark_pools_id"></a> [spark\_pools\_id](#output\_spark\_pools\_id) | The Spark Pools ID. |
| <a name="output_sql_administrator_password"></a> [sql\_administrator\_password](#output\_sql\_administrator\_password) | SQL administrator password. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/fdmsantos/terraform-azurerm-synapse/tree/main/LICENSE) for full details.
