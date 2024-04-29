
resource "azurerm_resource_group" "this" {
  name     = "RG-${var.name}"
  location = var.location
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

module "storage_account" {
  source                             = "claranet/storage-account/azurerm"
  version                            = "7.10.0"
  storage_account_custom_name        = "demo${random_string.random.result}" # TODO Change this
  location                           = var.location
  resource_group_name                = azurerm_resource_group.this.name
  hns_enabled                        = true
  account_replication_type           = "LRS" # TODO Verify This
  network_rules_enabled              = false # TODO Verify what is this
  use_caf_naming                     = false
  default_tags_enabled               = false
  advanced_threat_protection_enabled = false
  storage_blob_data_protection = {
    versioning_enabled = false
  }
  logs_destinations_ids = []      # Not Used
  location_short        = ""      # Not Used
  client_name           = ""      # Not Used
  environment           = ""      # Not Used
  stack                 = "dummy" # Not Used
}

module "adls" {
  source                = "data-platform-hq/adls-v2/azurerm"
  name                  = "${var.name}-adls" # TODO Change this name
  storage_role_assigned = true
  storage_account_id    = module.storage_account.storage_account_id
  storage_account_name  = module.storage_account.storage_account_name
  ace_default           = []
}

module "synapse" {
  source                               = "../../"
  name                                 = var.name
  resource_group_name                  = azurerm_resource_group.this.name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = module.adls.id
  storage_account_id                   = module.storage_account.storage_account_id
  identity_type                        = "SystemAssigned"
  allow_azure_services_access          = true
  allow_own_ip                         = true
  firewall_rules = [
    {
      name             = "DummyIP"
      start_ip_address = "10.0.0.0"
      end_ip_address   = "10.0.0.0"
    }
  ]
  github = {
    account_name    = "dummy"
    repository_name = "dummy"
    branch_name     = "main"
    root_folder     = "/synapse"
  }
}
