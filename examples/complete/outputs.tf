output "synapse_id" {
  description = "The ID of the synapse Workspace."
  value       = module.synapse.id
}

output "spark_pools_id" {
  description = "Spark Pools ID"
  value       = module.synapse.spark_pools_id
}
