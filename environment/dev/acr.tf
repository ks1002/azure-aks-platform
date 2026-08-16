resource "azurerm_container_registry" "main" {
  name                = "acraksplatformdevne"
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location

  sku           = "Basic"
  admin_enabled = false

  public_network_access_enabled = true

  tags = local.common_tags
}
