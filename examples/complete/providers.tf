provider "azurerm" {
  skip_provider_registration = true
  features {
    application_insights {
      disable_generated_rule = true
    }
    cognitive_account {
      purge_soft_delete_on_destroy = true
    }
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }

  subscription_id = var.subscription_id
}
