output "application_resource_group_name" {
  description = "Application resource group name"
  value       = azurerm_resource_group.application.name
}

output "management_resource_group_name" {
  description = "Management resource group name"
  value       = azurerm_resource_group.management.name
}

output "application_vnet_name" {
  description = "Application VNet name"
  value       = azurerm_virtual_network.application.name
}

output "management_vnet_name" {
  description = "Management VNet name"
  value       = azurerm_virtual_network.management.name
}

output "aks_subnet_id" {
  description = "AKS subnet resource ID"
  value       = azurerm_subnet.aks.id
}

output "private_endpoint_subnet_id" {
  description = "Private Endpoint subnet resource ID"
  value       = azurerm_subnet.private_endpoints.id
}

output "management_subnet_id" {
  description = "Management subnet resource ID"
  value       = azurerm_subnet.management.id
}
output "aks_nsg_name" {
  description = "AKS subnet Network Security Group"
  value       = azurerm_network_security_group.aks.name
}

output "management_nsg_name" {
  description = "Management subnet Network Security Group"
  value       = azurerm_network_security_group.management.name
}

output "private_endpoint_nsg_name" {
  description = "Private Endpoint subnet Network Security Group"
  value       = azurerm_network_security_group.private_endpoints.name
}

output "application_to_management_peering_id" {
  description = "Application to management VNet peering ID"
  value       = azurerm_virtual_network_peering.application_to_management.id
}

output "management_to_application_peering_id" {
  description = "Management to application VNet peering ID"
  value       = azurerm_virtual_network_peering.management_to_application.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name"
  value       = azurerm_log_analytics_workspace.main.name
}

output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace resource ID"
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_workspace_id" {
  description = "Log Analytics Workspace customer/workspace ID"
  value       = azurerm_log_analytics_workspace.main.workspace_id
}
output "acr_name" {
  description = "Azure Container Registry name"
  value       = azurerm_container_registry.main.name
}

output "acr_id" {
  description = "Azure Container Registry resource ID"
  value       = azurerm_container_registry.main.id
}

output "acr_login_server" {
  description = "Azure Container Registry login server"
  value       = azurerm_container_registry.main.login_server
}
output "application_key_vault_name" {
  description = "Application Key Vault name"
  value       = azurerm_key_vault.application.name
}

output "application_key_vault_id" {
  description = "Application Key Vault resource ID"
  value       = azurerm_key_vault.application.id
}

output "application_key_vault_uri" {
  description = "Application Key Vault URI"
  value       = azurerm_key_vault.application.vault_uri
}
output "aks_control_plane_identity_id" {
  description = "AKS control plane user-assigned identity ID"
  value       = azurerm_user_assigned_identity.aks_control_plane.id
}

output "aks_control_plane_principal_id" {
  description = "AKS control plane managed identity principal ID"
  value       = azurerm_user_assigned_identity.aks_control_plane.principal_id
}
output "aks_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.main.name
}

output "aks_id" {
  description = "AKS cluster resource ID"
  value       = azurerm_kubernetes_cluster.main.id
}

output "aks_kubelet_identity_object_id" {
  description = "AKS kubelet managed identity object ID"
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}
output "aks_workload_identity_client_id" {
  description = "Client ID of AKS application workload identity"
  value       = azurerm_user_assigned_identity.aks_workload.client_id
}

output "aks_workload_identity_principal_id" {
  description = "Principal ID of AKS application workload identity"
  value       = azurerm_user_assigned_identity.aks_workload.principal_id
}

output "aks_oidc_issuer_url" {
  description = "AKS OIDC issuer URL"
  value       = azurerm_kubernetes_cluster.main.oidc_issuer_url
}

