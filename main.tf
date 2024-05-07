resource "random_password" "sql_password" {
  count            = !var.azuread_authentication_only && var.auth_sql_administrator_password == null ? 1 : 0
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_synapse_workspace" "this" {
  name                                 = var.name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_data_lake_gen2_filesystem_id
  sql_administrator_login              = !var.azuread_authentication_only ? coalesce(var.auth_sql_administrator, "sqladminuser") : null
  sql_administrator_login_password     = !var.azuread_authentication_only ? coalesce(var.auth_sql_administrator_password, random_password.sql_password[0].result) : null
  azuread_authentication_only          = var.azuread_authentication_only

  dynamic "aad_admin" {
    for_each = var.aad_admin != null ? [var.aad_admin] : []
    content {
      login     = aad_admin.value.login
      object_id = aad_admin.value.object_id
      tenant_id = aad_admin.value.tenant_id
    }
  }

  dynamic "github_repo" {
    for_each = var.github != null ? [var.github] : []
    content {
      account_name    = github_repo.value.account_name
      repository_name = github_repo.value.repository_name
      branch_name     = github_repo.value.branch_name
      root_folder     = github_repo.value.root_folder
      git_url         = lookup(github_repo.value, "git_url", null)
      last_commit_id  = lookup(github_repo.value, "last_commit_id", null)
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type == "BOTH" ? "SystemAssigned, UserAssigned" : var.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = var.tags
}

############################### Access Control ###############################
resource "azurerm_role_assignment" "storage_blob_contributor" {
  count                = var.add_storage_contributor_role ? length(azurerm_synapse_workspace.this.identity) : 0
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_synapse_workspace.this.identity[count.index].principal_id
}

resource "azurerm_synapse_role_assignment" "this" {
  count                = length(var.synapse_role_assignments)
  synapse_workspace_id = azurerm_synapse_workspace.this.id
  role_name            = var.synapse_role_assignments[count.index].role_name
  principal_id         = var.synapse_role_assignments[count.index].principal_id
  principal_type       = var.synapse_role_assignments[count.index].principal_type
}
############################### Firewall Rules ###############################
resource "azurerm_synapse_firewall_rule" "this" {
  count                = length(var.firewall_rules)
  synapse_workspace_id = azurerm_synapse_workspace.this.id
  name                 = var.firewall_rules[count.index].name
  start_ip_address     = var.firewall_rules[count.index].start_ip_address
  end_ip_address       = var.firewall_rules[count.index].end_ip_address
}

resource "azurerm_synapse_firewall_rule" "azureservices" {
  count                = var.allow_azure_services_access ? 1 : 0
  synapse_workspace_id = azurerm_synapse_workspace.this.id
  name                 = "AllowAllWindowsAzureIps"
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "0.0.0.0"
}

resource "azurerm_synapse_firewall_rule" "client_ip" {
  count                = var.allow_own_ip ? 1 : 0
  synapse_workspace_id = azurerm_synapse_workspace.this.id
  name                 = "ClientIp"
  start_ip_address     = chomp(data.http.client_ip[0].response_body)
  end_ip_address       = chomp(data.http.client_ip[0].response_body)
}
