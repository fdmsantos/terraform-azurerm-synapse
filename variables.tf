variable "name" {
  description = "Specifies the name which should be used for this synapse Workspace. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group where the synapse Workspace should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "Specifies the Azure Region where the synapse Workspace should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_data_lake_gen2_filesystem_id" {
  description = "Specifies the ID of storage data lake gen2 filesystem resource. Changing this forces a new resource to be created."
  type        = string
}

variable "azuread_authentication_only" {
  description = "Azure Active Directory Authentication the only way to authenticate with resources inside this synapse Workspace."
  type        = bool
  default     = false
}

variable "auth_sql_administrator" {
  description = "Specifies The login name of the SQL administrator. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "auth_sql_administrator_password" {
  description = "The Password associated with the sql_administrator_login for the SQL administrator."
  type        = string
  default     = null
  sensitive   = true
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Synapse Workspace."
  type        = map(string)
  default     = null
}

variable "aad_admin" {
  description = "Credentials of the Azure AD Administrator of this Synapse Workspace."
  type = object({
    login     = string
    tenant_id = string
    object_id = string
  })
  default = null
}

######### Identity #########
variable "identity_type" {
  description = "Specifies the type of Managed Service Identity that should be associated with this Logic App."
  type        = string
  default     = null
  validation {
    error_message = "Please use a valid source!"
    condition     = var.identity_type == null || can(contains(["SystemAssigned", "UserAssigned", "BOTH"], var.identity_type))
  }
}

variable "identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Synapse Workspace."
  type        = list(string)
  default     = []
}

######### Firewall Rules #########
variable "firewall_rules" {
  description = "Allows you to Manages a Synapse Firewall Rules."
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

variable "allow_azure_services_access" {
  description = "If true, allow Azure Services and Resources to access this workspace."
  type        = bool
  default     = false
}

variable "allow_own_ip" {
  description = "If true, create firewall rule to allow client IP to Synapse Workspace."
  type        = bool
  default     = false
}
######### Github #########
variable "github" {
  description = "Integrate Synapse Workspace with Github."
  type = object({
    account_name    = string
    repository_name = string
    branch_name     = string
    root_folder     = string
    last_commit_id  = optional(string)
    git_url         = optional(string)
  })
  default = null
}


######### Access Control #########
variable "add_storage_contributor_role" {
  description = "If true, add Storage Contributor Role to Synapse Workspace identity."
  type        = bool
  default     = true
}

variable "storage_account_id" {
  description = "Storage Account ID used by Synapse Workspace. Necessary if `add_storage_contributor_role` is true."
  type        = string
  default     = false
}

variable "synapse_role_assignments" {
  description = "Manages a Synapse Role Assignment."
  type = list(object({
    role_name      = string
    principal_id   = string
    principal_type = optional(string, null)
  }))
  default = []
}

######### Spark Pools #########
variable "spark_pools" {
  description = "Manages a Synapse Spark Pools."
  type = map(object({
    node_size_family                    = optional(string, "None")
    node_size                           = optional(string, "Small")
    node_count                          = optional(number, null)
    cache_size                          = optional(number, null)
    compute_isolation_enabled           = optional(bool, false)
    dynamic_executor_allocation_enabled = optional(bool, false)
    min_executors                       = optional(number, null)
    max_executors                       = optional(number, null)
    session_level_packages_enabled      = optional(bool, false)
    spark_log_folder                    = optional(string, "/logs")
    spark_events_folder                 = optional(string, "/events")
    spark_version                       = optional(string, "3.4")
    autoscale_max_node_count            = optional(number, null)
    autoscale_min_node_count            = optional(number, null)
    autopause_delay_in_minutes          = optional(number, null)
    requirements_content                = optional(string, null)
    requirements_filename               = optional(string, "requirements.txt")
    spark_config_content                = optional(string, null)
    spark_config_filename               = optional(string, "config.txt")
  }))
  default = {}
}

######### Linked Services #########
variable "linked_services" {
  description = "Manages a Synapse Linked Services."
  type = map(object({
    type                           = string
    type_properties_json           = string
    additional_properties          = optional(map(string), {})
    annotations                    = optional(list(string), [])
    description                    = optional(string, null)
    parameters                     = optional(map(string), {})
    integration_runtime_name       = optional(string, null)
    integration_runtime_parameters = optional(map(string), {})
  }))
  default = {}
}
