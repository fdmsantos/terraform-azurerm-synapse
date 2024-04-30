variable "subscription_id" {
  description = "Specifies the subscription id should be used for this synapse workspace."
  type        = string
}

variable "name" {
  description = "Specifies the name which should be used for this synapse Workspace. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "Specifies the Azure Region where the synapse Workspace should exist. Changing this forces a new resource to be created."
  type        = string
}
