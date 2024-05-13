#data "azurerm_client_config" "current" {}

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
  #   synapse_role_assignments = [{
  #     role_name    = "Synapse Administrator"
  #     principal_id = data.azurerm_client_config.current.object_id
  #   }]

  linked_services = {
    example = {
      type                 = "AzureBlobStorage"
      type_properties_json = <<JSON
{
  "connectionString": "${module.storage_account.storage_account_properties.primary_connection_string}"
}
JSON
    }
  }

  spark_pools = {
    testpool : {
      node_size_family : "MemoryOptimized"
      node_size : "Small"
      cache_size : 100
      session_level_packages_enabled : true
      spark_version : "3.3"
      autoscale_min_node_count : 3
      autoscale_max_node_count : 4
      autopause_delay_in_minutes : 5
      requirements_content : <<EOF
appnope==0.1.0
beautifulsoup4==4.6.3
EOF
      spark_config_content : <<EOF
spark.shuffle.spill                true
EOF
    }
  }
  azure_integration_runtimes = {
    azure : {
      location : "AutoResolve"
      compute_type : "General"
      core_count : 8
      description : "Azure Integration Runtime to Test"
      time_to_live_min : 0
    }
  }

  self_hosted_integration_runtimes = {
    self-hosted : {
      description : "Self Hosted Integration Runtime to Test"
    }
  }

}
