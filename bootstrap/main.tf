resource "azurerm_resource_group" "tfstate" {

  name     = "rg-${local.name_prefix}-tfstate"
  location = var.location

  tags = local.common_tags
}
resource "azurerm_storage_account" "tfstate" {

  name                = "youruniquestorageaccount"
  resource_group_name = azurerm_resource_group.tfstate.name
  location            = azurerm_resource_group.tfstate.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = local.common_tags
}
resource "azurerm_storage_container" "tfstate" {

  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}
resource "azurerm_role_assignment" "tfstate_blob_contributor" {
  scope                = azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
