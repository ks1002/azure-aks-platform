resource "azurerm_network_security_group" "aks" {
  name                = "nsg-${local.name_prefix}-aks"
  location            = azurerm_resource_group.application.location
  resource_group_name = azurerm_resource_group.application.name

  tags = local.common_tags
}

resource "azurerm_network_security_group" "private_endpoints" {
  name                = "nsg-${local.name_prefix}-private-endpoints"
  location            = azurerm_resource_group.application.location
  resource_group_name = azurerm_resource_group.application.name

  tags = local.common_tags
}

resource "azurerm_network_security_group" "management" {
  name                = "nsg-${local.name_prefix}-mgmt"
  location            = azurerm_resource_group.management.location
  resource_group_name = azurerm_resource_group.management.name

  tags = local.common_tags
}
resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks.id
}

resource "azurerm_subnet_network_security_group_association" "private_endpoints" {
  subnet_id                 = azurerm_subnet.private_endpoints.id
  network_security_group_id = azurerm_network_security_group.private_endpoints.id
}

resource "azurerm_subnet_network_security_group_association" "management" {
  subnet_id                 = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.management.id
}
