resource "azurerm_user_assigned_identity" "aks_control_plane" {
  name                = "id-${local.name_prefix}-aks"
  location            = azurerm_resource_group.application.location
  resource_group_name = azurerm_resource_group.application.name

  tags = local.common_tags
}
resource "azurerm_role_assignment" "aks_subnet_network_contributor" {
  scope                = azurerm_subnet.aks.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_control_plane.principal_id
}
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}

resource "azurerm_user_assigned_identity" "aks_workload" {
  name                = "id-${local.name_prefix}-workload"
  location            = azurerm_resource_group.application.location
  resource_group_name = azurerm_resource_group.application.name

  tags = local.common_tags
}
resource "azurerm_role_assignment" "aks_workload_key_vault_secrets_user" {
  scope                = azurerm_key_vault.application.id
  role_definition_name = "Key Vault Secrets User"

  principal_id = azurerm_user_assigned_identity.aks_workload.principal_id
}
resource "azurerm_federated_identity_credential" "aks_workload" {
  name = "fic-${local.name_prefix}-keyvault"

  user_assigned_identity_id = azurerm_user_assigned_identity.aks_workload.id

  audience = [
    "api://AzureADTokenExchange"
  ]

  issuer = azurerm_kubernetes_cluster.main.oidc_issuer_url

  subject = "system:serviceaccount:app:kv-reader"
}
