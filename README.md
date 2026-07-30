# Azure Storage Account – Bicep Deployment

A parameterized Bicep template for deploying an Azure Storage Account (`StorageV2`), built as part of hands-on Azure IaC practice.

## What it deploys

- A single **StorageV2** account
- Configurable **SKU** (redundancy) — Standard_LRS, Standard_GRS, Standard_RAGRS, Standard_ZRS, Premium_LRS, Premium_ZRS
- Configurable **access tier** — Hot or Cool
- Custom **resource tags** (e.g. Environment, Department)
- Outputs the resource ID, name, and primary endpoints for downstream use

## Why

Storage accounts are one of the most common building blocks in Azure landing zones. This template demonstrates:
- Parameter validation with `@minLength`, `@maxLength`, and `@allowed`
- Safe defaults with override support at deploy time
- Clean output values that can feed into other modules (e.g. app services, backends)

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) with the Bicep extension (`az bicep install` / `az bicep upgrade`)
- An active Azure subscription
- Logged in via `az login` (or `Connect-AzAccount` for PowerShell)

## Usage

### 1. Create a resource group (if needed)

```bash
az group create --name rg-storage-demo --location canadacentral
```

### 2. Preview the deployment (recommended)

```bash
az deployment group what-if \
  --resource-group rg-storage-demo \
  --template-file storageAccount.bicep
```

### 3. Deploy

```bash
az deployment group create \
  --resource-group rg-storage-demo \
  --template-file storageAccount.bicep \
  --parameters storageAccountName=stgniklabs001
```

> Storage account names must be globally unique, lowercase, and alphanumeric only (3–24 characters). Override the default with `--parameters storageAccountName=<yourUniqueName>`.

### PowerShell equivalent

```powershell
New-AzResourceGroupDeployment `
  -ResourceGroupName rg-storage-demo `
  -TemplateFile storageAccount.bicep `
  -storageAccountName "stgniklabs001"
```

### 4. Verify

```bash
az storage account show --name stgniklabs001 --resource-group rg-storage-demo --output table
```

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `storageAccountName` | string | `stgactname001` | Globally unique storage account name (3–24 chars, lowercase/numbers) |
| `stgactsku` | string | `Standard_LRS` | Storage redundancy SKU |
| `stgactTier` | string | `Cool` | Access tier — `Hot` or `Cool` |
| `stgactags` | object | `{ Environment: 'Dev', Department: 'IT' }` | Resource tags |

## Outputs

| Output | Description |
|---|---|
| `storageAccountId` | Full resource ID of the deployed storage account |
| `storageAccountName` | Name of the deployed storage account |
| `primaryEndpoints` | Object containing blob/file/queue/table endpoint URLs |

## Author

Nikhil Seth — [niklabs.org](https://niklabs.org) | [GitHub](https://github.com/Nikhilse120)
