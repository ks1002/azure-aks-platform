# Azure AKS Platform Engineering Lab

A hands-on Azure platform engineering project built using Terraform,
Azure Kubernetes Service (AKS), Docker and Kubernetes.

The purpose of this project was to build an Azure AKS platform from
scratch and understand the infrastructure, networking, identity,
security and application deployment flow.

## Architecture

The platform contains:

- Azure Resource Groups
- Application and Management VNets
- Dedicated subnets
- Network Security Groups
- VNet Peering
- Azure Kubernetes Service
- Azure Container Registry
- Azure Key Vault
- Log Analytics
- AKS Workload Identity
- OIDC Federation
- Key Vault Secrets Store CSI Driver
- Kubernetes Deployment
- Kubernetes ClusterIP Service
- Containerized Python backend

## Infrastructure as Code

Terraform is used to provision the Azure infrastructure.

The project is divided into:

- `bootstrap/` - Terraform state storage infrastructure
- `environment/dev/` - Development Azure environment

## Application

A small Python/Flask backend was containerized using Docker and
published to Azure Container Registry.

The application exposes:

- `/`
- `/health`
- `/api/status`
- `/api/secret-status`

## AKS and ACR

AKS uses its kubelet managed identity to pull container images from
Azure Container Registry without registry usernames or passwords.

## Workload Identity

AKS Workload Identity and OIDC federation are used so Kubernetes
workloads can authenticate to Azure using a dedicated user-assigned
managed identity.

No Azure application password or client secret is stored inside
Kubernetes.

## Key Vault

The backend accesses Azure Key Vault using:

Kubernetes ServiceAccount
→ AKS OIDC
→ Federated Identity Credential
→ User Assigned Managed Identity
→ Key Vault RBAC

The Azure Key Vault Secrets Store CSI Driver mounts Key Vault secrets
into the application pod.

## Kubernetes

The backend uses:

- Deployment
- ClusterIP Service
- Readiness probe
- Liveness probe
- Resource requests and limits
- Workload Identity
- Key Vault CSI volume

## Project Structure

```text
azure-aks-platform/
├── application/
│   └── backend/
├── bootstrap/
├── environment/
│   └── dev/
└── kubernetes/
    ├── backend/
    └── workload-identity/
