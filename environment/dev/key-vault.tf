resource "azurerm_key_vault" "application" {
  name                = "kv-aksplatform-dev-ne"
  location            = azurerm_resource_group.application.location
  resource_group_name = azurerm_resource_group.application.name

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = "standard"

  rbac_authorization_enabled = true

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  public_network_access_enabled = true

  tags = local.common_tags
}
resource "azurerm_role_assignment" "current_user_key_vault_secrets_officer" {
  scope                = azurerm_key_vault.application.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}
