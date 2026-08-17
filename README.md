# Azure AKS Platform Engineering Lab

A hands-on Azure platform engineering project built using Terraform,
Azure Kubernetes Service (AKS), Docker and Kubernetes.

The purpose of this project was to build an Azure AKS platform from
scratch and understand the infrastructure, networking, identity,
security and application deployment flow and The focus was on understanding how the different Azure and Kubernetes components fit together, especially networking, container image access and secret management.

The lab was created in my personal Azure subscription and the infrastructure was destroyed after testing so that I was not leaving resources running unnecessarily.



## Architecture

The platform contains:

- Azure Resource Groups (Separate Application and Management resource groups)
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

## Architecture

                         Azure Subscription
                                |
             +------------------+------------------+
             |                                     |
     Application Resource Group            Management Resource Group
             |                                     |
      Application VNet                         Management VNet
             |                                     |
      +------+-------+                         Log Analytics
      |              |
   AKS subnet   Private Endpoint subnet
      |
      v
     AKS
      |
      +--------------------------+
      |                          |
      v                          v
     ACR                     Key Vault
 backend:v1                     ^
      |                          |
      |                 Workload Identity
      |                  + OIDC Federation
      |                          |
      +----------> Backend Pod --+
                       |
                       v
                ClusterIP Service

The current lab keeps the backend internal through a ClusterIP Service. External application routing is intentionally left for the next phase.


## Infrastructure as Code

Terraform is used to provision the Azure infrastructure.

The project is divided into:

-bootstrap/ - creates the storage required for remote Terraform state

-environment/dev/ - creates the development Azure environment

Terraform manages the Azure resources while Kubernetes manifests manage the application resources inside AKS.

This separation was intentional:

Terraform
   |
   +--> Resource Groups
   +--> VNets / Subnets / NSGs
   +--> AKS
   +--> ACR
   +--> Key Vault
   +--> Log Analytics
   +--> Managed Identities
   +--> Azure RBAC

Kubernetes YAML
   |
   +--> Namespace
   +--> ServiceAccount
   +--> SecretProviderClass
   +--> Deployment
   +--> Service



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

azure-aks-platform/
├── application/
│   └── backend/
│       ├── app.py
│       ├── Dockerfile
│       ├── requirements.txt
│       └── .dockerignore
│
├── bootstrap/
│   ├── backend.tf.example
│   ├── terraform.tfvars.example
│   └── ...
│
├── environment/
│   └── dev/
│       ├── acr.tf
│       ├── aks.tf
│       ├── identity.tf
│       ├── key-vault.tf
│       ├── log-analytics.tf
│       ├── network.tf
│       ├── nsg.tf
│       ├── peering.tf
│       ├── resource-groups.tf
│       ├── backend.tf
│       ├── backend.hcl.example
│       ├── terraform.tfvars.example
│       └── ...
│
└── kubernetes/
    ├── backend/
    │   ├── deployment.yaml
    │   └── service.yaml
    │
    └── workload-identity/
        ├── namespace.yaml
        ├── serviceaccount.yaml
        ├── secretproviderclass.yaml
        └── test-pod.yaml


## Destroying the lab

The lab is designed to be temporary.

Destroy the development environment first:

cd environment/dev

terraform plan -destroy
terraform destroy

The bootstrap/state-storage layer should be handled separately after the development environment is removed.


