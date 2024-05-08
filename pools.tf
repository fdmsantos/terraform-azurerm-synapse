resource "azurerm_synapse_spark_pool" "this" {
  for_each                            = var.spark_pools
  name                                = each.key
  synapse_workspace_id                = azurerm_synapse_workspace.this.id
  node_size_family                    = each.value["node_size_family"]
  node_size                           = each.value["node_size"]
  node_count                          = each.value["node_count"]
  cache_size                          = each.value["cache_size"]
  compute_isolation_enabled           = each.value["compute_isolation_enabled"]
  dynamic_executor_allocation_enabled = each.value["dynamic_executor_allocation_enabled"]
  min_executors                       = each.value["min_executors"]
  max_executors                       = each.value["max_executors"]
  session_level_packages_enabled      = each.value["session_level_packages_enabled"]
  spark_log_folder                    = each.value["spark_log_folder"]
  spark_events_folder                 = each.value["spark_events_folder"]
  spark_version                       = each.value["spark_version"]

  dynamic "auto_scale" {
    for_each = each.value["autoscale_max_node_count"] != null ? [1] : []
    content {
      max_node_count = each.value["autoscale_max_node_count"]
      min_node_count = each.value["autoscale_min_node_count"]
    }
  }

  dynamic "auto_pause" {
    for_each = each.value["autopause_delay_in_minutes"] != null ? [1] : []
    content {
      delay_in_minutes = each.value["autopause_delay_in_minutes"]
    }
  }

  dynamic "library_requirement" {
    for_each = each.value["requirements_content"] != null ? [1] : []
    content {
      content  = each.value["requirements_content"]
      filename = each.value["requirements_filename"]
    }
  }

  dynamic "spark_config" {
    for_each = each.value["spark_config_content"] != null ? [1] : []
    content {
      content  = each.value["spark_config_content"]
      filename = each.value["spark_config_filename"]
    }
  }

  tags = var.tags
}
