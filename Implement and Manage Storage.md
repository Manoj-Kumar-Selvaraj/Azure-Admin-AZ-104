
---

# Implement and Manage Storage (15–20%)

Azure Storage is a core service that provides scalable, durable, and secure storage solutions for cloud workloads. This section covers **access control, storage accounts, and file/blob services**.

---

## 🔐 Access Control

### Configure Firewalls and VNets for Storage

* By default, storage accounts are accessible from **all networks**.
* You can restrict access to:

  * **Selected VNets and subnets**
  * **Specific public IP addresses**
  * **Private endpoints** (preferred for secure traffic)

**Azure CLI:**

```bash
az storage account update \
  --name mystorageacct \
  --resource-group myrg \
  --default-action Deny
```

**Terraform:**

```hcl
network_rules {
  default_action             = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.example.id]
  ip_rules                   = ["52.168.10.1"]
}
```

✅ **Best practice:** Always use **private endpoints** over public access.

---

### Create and Use SAS Tokens

* **Shared Access Signature (SAS):** Grants limited access to storage (time-bound & permission-based).
* Types:

  * **Account SAS:** Access across all services in an account.
  * **Service SAS:** Access to a specific service (Blob/File/Queue/Table).
  * **User Delegation SAS:** Uses Azure AD credentials (more secure).

**Azure CLI Example:**

```bash
az storage blob generate-sas \
  --account-name mystorageacct \
  --container-name mycontainer \
  --name myblob.txt \
  --permissions r \
  --expiry 2025-12-31T23:59:00Z \
  --https-only
```

✅ **Exam tip:** SAS = temporary access. Prefer **User Delegation SAS** when using Azure AD.

---

### Configure Stored Access Policies

* Define reusable access policies at **container/share/table/queue** level.
* SAS tokens can reference a stored policy → easier to revoke or extend.

Example:

```bash
az storage container policy create \
  --account-name mystorageacct \
  --container-name mycontainer \
  --name readonlypolicy \
  --start 2025-09-01T00:00Z \
  --expiry 2025-09-07T00:00Z \
  --permissions r
```

---

### Manage Access Keys

* Each storage account has **two keys** for redundancy/rotation.
* Use **Azure Key Vault** to securely store and rotate them.

**Rotate keys with CLI:**

```bash
az storage account keys renew \
  --resource-group myrg \
  --account-name mystorageacct \
  --key primary
```

✅ **Best practice:** Prefer **Azure AD RBAC** or **SAS tokens** instead of hardcoding keys.

---

### Configure Identity-Based Access for Azure Files

* You can use **Azure AD DS** or **Entra ID Kerberos** for SMB authentication.
* RBAC roles grant access → `Storage File Data SMB Share Reader/Contributor/Elevated Contributor`.

**Terraform Example:**

```hcl
identity {
  type = "SystemAssigned"
}
```

---

## 🗂 Storage Accounts

### Create and Configure Storage Accounts

* Storage account types:

  * **General-purpose v2 (recommended)** – supports all features.
  * **BlockBlobStorage** – optimized for blob workloads.
  * **FileStorage** – premium file shares.

**Terraform Example:**

```hcl
resource "azurerm_storage_account" "example" {
  name                     = "mystorageacct"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

---

### Configure Redundancy and Replication

* **LRS:** Local redundancy (cheapest, same DC).
* **ZRS:** Zone redundancy (3 AZs).
* **GRS/RA-GRS:** Geo-redundant (secondary region, read-only RA).
* **GZRS/RA-GZRS:** Geo + zone redundancy.

✅ **Exam tip:**

* Use **ZRS** for high durability in region.
* Use **GRS/RA-GRS** for cross-region resilience.

---

### Configure Encryption

* Azure Storage encrypts data at rest using **AES-256**.
* Options:

  * Microsoft-managed keys (default).
  * Customer-managed keys in Key Vault.
  * Customer-provided keys (per request).

---

### Manage Data with Storage Explorer & AzCopy

* **Storage Explorer:** GUI tool for browsing/uploading/downloading.
* **AzCopy:** CLI tool for high-performance transfers.

**Example:**

```bash
# Upload a file
azcopy copy "file.txt" "https://mystorageacct.blob.core.windows.net/mycontainer?sas_token"
```

---

## 📦 Files & Blob Storage

### Azure Files

* **File shares** (SMB or NFS).
* Features:

  * Snapshots
  * Soft delete (recover deleted shares)
  * Azure File Sync (hybrid)

**Terraform Example:**

```hcl
resource "azurerm_storage_share" "example" {
  name                 = "myfileshare"
  storage_account_name = azurerm_storage_account.example.name
  quota                = 50
}
```

---

### Azure Blob Storage

* Blob types: **Block, Append, Page**.
* Features:

  * Tiers: **Hot, Cool, Archive**
  * Soft delete for blobs/containers
  * Lifecycle management rules (move between tiers, delete old files)
  * Versioning (track blob changes)

**Lifecycle Policy Example (JSON):**

```json
{
  "rules": [
    {
      "name": "moveToCool",
      "enabled": true,
      "filters": { "blobTypes": ["blockBlob"] },
      "actions": {
        "baseBlob": { "tierToCool": { "daysAfterModificationGreaterThan": 30 } }
      }
    }
  ]
}
```

---

## 📋 Quick Revision Checklist

* [ ] Configure storage firewalls & VNets (use private endpoints ✅)
* [ ] Generate SAS tokens (prefer user delegation SAS)
* [ ] Use stored access policies for SAS management
* [ ] Rotate and secure access keys (prefer AD/RBAC)
* [ ] Configure identity-based access for Azure Files
* [ ] Create and configure storage accounts (use GPv2)
* [ ] Choose redundancy: LRS / ZRS / GRS / RA-GRS / GZRS
* [ ] Configure encryption (default = Microsoft-managed)
* [ ] Transfer/manage data with AzCopy & Storage Explorer
* [ ] Use Azure Files (shares, snapshots, soft delete)
* [ ] Configure Blob storage (tiers, lifecycle rules, versioning, soft delete)

---

