# Azure Synapse Terraform Module

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

Dynamic Terraform Module to create Azure Synapse Workspace and all Related Resources.

## Table of Contents

* [Module versioning rule](README.md#module-versioning-rule)
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

## License

Apache 2 Licensed. See [LICENSE](https://github.com/fdmsantos/terraform-azurerm-synapse/tree/main/LICENSE) for full details.
