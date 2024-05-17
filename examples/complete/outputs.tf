output "synapse_id" {
  description = "The ID of the synapse Workspace."
  value       = module.synapse.id
}

output "spark_pools_id" {
  description = "Spark Pools ID"
  value       = module.synapse.spark_pools_id
}

output "linked_services_id" {
  description = "Linked Services ID"
  value       = module.synapse.linked_services_id
}

output "azure_integration_runtime_id" {
  description = "Azure Integrated Runtime ID"
  value       = module.synapse.azure_integration_runtimes_id
}

output "self_hosted_integration_runtime_id" {
  description = "Self Hosted Integrations Runtime ID"
  value       = module.synapse.self_hosted_integration_runtimes_id
}

output "sql_pools_id" {
  description = "SQL Pools ID"
  value       = module.synapse.sql_pools_id
}
