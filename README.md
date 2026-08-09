# Low-Cost Azure Kubernetes Service (AKS) with Terraform & GitHub Actions

This repository provides a modular, multi-environment Terraform configuration (`preprod` and `prod`) and an automated GitHub Actions pipeline to deploy AKS clusters optimized for lab practice at minimal Azure cost.

---

## 🎯 Architecture & Environment Directory Structure

```
aks-terraform-github-actions/
├── .github/
│   └── workflows/
│       └── terraform.yml            # Matrix CI/CD pipeline (Preprod & Prod)
├── modules/                         # Reusable child modules
│   ├── resource_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── aks/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/
│   ├── preprod/                     # Preprod environment configuration
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── terraform.tfvars
│   └── prod/                        # Prod environment configuration
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── terraform.tfvars
├── .gitignore
└── README.md                        # Documentation & lab guide
```

---

## 🔄 Git Branching & Pipeline Workflow Rules

| Trigger Source | Events | Workflow Actions Executed |
|---|---|---|
| **Feature Branches** (`feature/*`, `feat/*`, etc.) | `push` | `terraform fmt`, `init`, `validate`, `plan` |
| **Pull Requests** | `pull_request` to `main` | `terraform fmt`, `init`, `validate`, `plan` |
| **Merge to Main** | `push` to `main` | `terraform fmt`, `init`, `validate`, `plan`, **`terraform apply`** |
| **Manual Trigger** | `workflow_dispatch` | Select environment (`preprod`/`prod`/`all`) & action (`plan`/`apply`/`destroy`) |

---

## 💰 Cost Optimization Features

| Feature | Setting | Cost Savings Rationale |
|---|---|---|
| **SKU Tier** | `Free` | Eliminates the $0.10/hr control plane charge ($73/month savings). |
| **Node VM Size** | `Standard_B2s` | Burstable B-series (2 vCPU, 4GB RAM) @ ~$0.0416/hr per node. |
| **Node Count** | `2` | Satisfies 2-node Kubernetes lab requirement with minimal spend. |
| **OS Disk** | `30 GB Managed` | Small disk footprint saves storage fees compared to default 128GB disks. |
| **Network Plugin** | `kubenet` | Basic overlay networking reduces Azure network infrastructure cost. |

---

## 💡 How `for_each` and `Map` are Used

Each environment (`preprod` and `prod`) defines `var.aks_clusters` as a `map(object({...}))` in `variables.tf`.

In `environments/preprod/main.tf` & `environments/prod/main.tf`, `for_each` iterates over the `aks_clusters` map to pass values dynamically to child modules:

```hcl
module "resource_group" {
  source   = "../../modules/resource_group"
  for_each = var.aks_clusters

  name     = each.value.rg_name
  location = each.value.location
  tags     = each.value.tags
}

module "aks" {
  source   = "../../modules/aks"
  for_each = var.aks_clusters

  cluster_name        = each.key
  resource_group_name = module.resource_group[each.key].name
  location            = each.value.location
  kubernetes_version  = each.value.kubernetes_version
  node_count          = each.value.node_count
  vm_size             = each.value.vm_size
  os_disk_size_gb     = each.value.os_disk_size_gb
  tags                = each.value.tags

  depends_on = [module.resource_group]
}
```

---

## 🚀 Quick Start (Local Deployment)

Navigate to the target environment folder (`environments/preprod` or `environments/prod`):

```bash
cd environments/preprod  # Or environments/prod

# Initialize Terraform
terraform init

# Validate configuration syntax
terraform validate

# View execution plan
terraform plan

# Apply infrastructure changes
terraform apply
```

To connect to the created cluster:
```bash
az aks get-credentials --resource-group rg-aks-preprod --name aks-preprod-cluster
kubectl get nodes
```

---

## ⚡ Essential Lab Cost-Saving Commands

When finished practicing for the day, **stop the AKS nodes** to pause compute billing completely:

```bash
# Stop preprod cluster nodes (compute cost drops to $0)
az aks stop --name aks-preprod-cluster --resource-group rg-aks-preprod

# Stop prod cluster nodes
az aks stop --name aks-prod-cluster --resource-group rg-aks-prod

# Resume preprod cluster nodes
az aks start --name aks-preprod-cluster --resource-group rg-aks-preprod

# Tear down environment resources completely when lab practice is finished
cd environments/preprod && terraform destroy
`````
## need to check

---

## ⚙️ GitHub Secrets Setup

Add the following repository secrets under `Settings -> Secrets and variables -> Actions`:
- `AZURE_CLIENT_ID`: Azure App registration client ID
- `AZURE_TENANT_ID`: Directory / Tenant ID
- `AZURE_SUBSCRIPTION_ID`: Subscription ID
- `AZURE_CLIENT_SECRET`: Client secret (if using secret authentication) or `AZURE_CREDENTIALS` (JSON output from `az ad sp create-for-rbac`).
