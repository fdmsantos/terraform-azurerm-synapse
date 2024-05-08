output "id" {
  description = "The ID of the synapse Workspace."
  value       = azurerm_synapse_workspace.this.id
}

output "endpoints" {
  description = "A list of Connectivity endpoints for this Synapse Workspace."
  value       = azurerm_synapse_workspace.this.connectivity_endpoints
}

output "sql_administrator_password" {
  description = "SQL administrator password."
  value       = !var.azuread_authentication_only ? coalesce(var.auth_sql_administrator_password, random_password.sql_password[0].result) : null
  sensitive   = true
}

output "identity" {
  description = "The Principal ID and Tenant ID for the Service Principal associated with the Managed Service Identity of this Synapse Workspace."
  value       = azurerm_synapse_workspace.this.identity
}

########## Spark Pools ##########
output "spark_pools_id" {
  description = "The Spark Pools ID."
  value = {
    for k, v in azurerm_synapse_spark_pool.this : k => v.id
  }
}
