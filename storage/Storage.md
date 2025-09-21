# AZ-104: Implement and Manage Storage

## 1 Storage Accounts

### Create and Configure Storage Accounts

## Create and Configure Storage Accounts

### 📘 Concept & Definition

- An **Azure Storage Account** is a **container** that holds all your Azure Storage data objects:
  - Blobs (unstructured data, images, videos, backups, logs)
  - Files (shared files accessible via SMB/NFS)
  - Queues (messaging for decoupled apps)
  - Tables (NoSQL key-value store)
  - Disks (managed disks for VMs)

- Think of it as the **top-level namespace** for your storage services.  
  Example:  
  If your storage account is named `mystorage123`, the blob endpoint will be:  https://mystorage123.blob.core.windows.net/

  
- A storage account provides:
- A **unique namespace** in Azure.
- **Scalability** (up to exabytes of data).
- **High availability & durability** (depending on replication).
- **Security features** (encryption, firewalls, private endpoints, identity-based access).

- **Why it matters (Exam context)**:
- Almost all storage configurations in Azure **start with a storage account**.
- Choosing the correct **type of storage account** is critical (e.g., General-purpose v2 vs. Premium).
- The account defines **performance**, **replication**, and **pricing**.

### ⚡ Types of Storage Accounts & When to Choose Them

Azure offers several types of storage accounts. Choosing the right one is critical for **performance, cost, and features**.

---

#### 1. **General-purpose v2 (GPv2)**
- ✅ Default & most recommended for new workloads.
- Supports **Blobs, Files, Queues, Tables, Disks**.
- Offers **all tiers**: Hot, Cool, Archive.
- Flexible redundancy: LRS, ZRS, GRS, RA-GRS.
- Cost-effective & scalable.

**When to use:**
- General apps needing multiple storage services.
- Web apps storing images, videos, logs.
- Backup & restore scenarios.
- Most workloads unless you have a **specialized performance need**.

---

#### 2. **General-purpose v1 (GPv1)**
- Legacy account type.
- Supports Blobs, Files, Queues, Tables, Disks.
- No access to some advanced features (e.g., tiering, ZRS).
- Slightly different (cheaper in rare cases) pricing model.

**When to use:**
- Only if migrating old workloads.
- Otherwise, avoid — always choose **GPv2**.

---

#### 3. **BlockBlob Storage Account**
- Specialized for **block blobs** (text/binary objects).
- Optimized for **large amounts of unstructured data**.
- Premium performance (low latency, SSD-based).
- No support for tables, queues, or files.

**When to use:**
- Streaming video/audio workloads.
- Logs and telemetry storage with high throughput.
- Data analytics pipelines.
- High transaction blob workloads.

---

#### 4. **Blob Storage Account** (legacy, similar to BlockBlob but only for blobs)
- Hot and cool access tiers.
- Used mainly for blob-only workloads.
- GPv2 has replaced this in most cases.

**When to use:**
- Rarely. Prefer **BlockBlob (Premium)** or **GPv2**.

---

#### 5. **Premium Storage Account Types**
Premium storage is SSD-backed and designed for **low-latency, high-IOPS workloads**.

- **Premium BlockBlob**  
  Optimized for workloads needing very fast blob access.  
  Example: Media streaming, IoT telemetry.  

- **Premium PageBlob (Managed Disks)**  
  Designed for **Azure VM disks**. High-performance storage for databases and transactional systems.  
  Example: SQL Server, Oracle, SAP HANA.  

- **Premium File Shares**  
  Optimized Azure Files with low latency.  
  Example: Lift-and-shift enterprise apps needing SMB shares.

---

### 📌 Practical Scenarios

| Scenario | Best Storage Account |
|----------|----------------------|
| Hosting images/videos for a web app | GPv2 (Blob Hot tier) |
| Storing infrequently accessed backups | GPv2 (Cool/Archive tier) |
| Running a production SQL/Oracle DB in Azure VM | Premium PageBlob (for managed disks) |
| Enterprise file shares replacing on-prem NAS | Premium File Shares |
| IoT device logs or telemetry at scale | BlockBlob or GPv2 (Hot tier) |
| Migrating an old storage workload | GPv1 (only if forced), otherwise upgrade to GPv2 |

---

### 💡 Exam Tips
- Always **prefer GPv2** unless a scenario specifically needs **premium performance**.
- Remember **Premium = SSD, low latency, high cost**.
- Know that **GPv1 & Blob Storage accounts are legacy** and mostly replaced by GPv2.
- For **VM disks → Premium PageBlob**;  
  For **high-throughput blobs → BlockBlob Premium**.

### 🔄 Storage Account Redundancy & Replication

Azure automatically keeps multiple copies of your data for **high availability** and **durability**.  
When creating a storage account, you must pick a **redundancy option**.

---

#### 📦 1. Local Redundant Storage (LRS)
- 3 copies of data in **one datacenter** (within a region).
- Cheapest option.
- Protects against **hardware failure**, but **not datacenter outage**.

**Use when:**
- Cost is a priority.
- Data can be easily re-created or recovered from elsewhere.

---

#### 🌐 2. Zone Redundant Storage (ZRS)
- 3 copies across **multiple Availability Zones** in the same region.
- Higher durability than LRS.
- Protects against **datacenter failure** (but not full regional outage).

**Use when:**
- Mission-critical workloads needing **zone-level durability**.
- Regions that support AZs (not available in all regions).

---

#### 🌍 3. Geo-Redundant Storage (GRS)
- 3 copies in primary region (like LRS) **+ 3 copies in paired secondary region**.
- Data is asynchronously replicated to another **geographically distant region**.
- Provides **regional outage protection**.
- Secondary is **not directly accessible**.

**Use when:**
- Disaster recovery is required.
- Regulatory compliance requires regional redundancy.

---

#### 🌍🔄 4. Read-Access Geo-Redundant Storage (RA-GRS)
- Same as GRS, but **secondary region is readable**.
- Provides read-only access if the primary region is down.

**Use when:**
- Need DR + **read-only access to secondary**.
- Example: Global applications serving content from multiple regions.

---

### 🌍 GZRS and RA-GZRS
#### 5. Geo-Zone Redundant Storage (GZRS) & Read-Access GZRS (RA-GZRS)
- Combines zone redundancy (ZRS) and geo-redundancy (GRS).
- Data is replicated across zones in the primary region and asynchronously to a secondary region.
- RA-GZRS allows read access to the secondary region.

**Use when:**
- Need both zone and geo redundancy for highest durability and DR.
- Critical workloads requiring maximum protection.

---

### 🔒 Encryption in Azure Storage

- **At Rest:** All data is encrypted by default using 256-bit AES. No action needed for basic protection.
- **Customer-Managed Keys (CMK):** For compliance, you can use your own keys in Azure Key Vault. Requires setup and incurs cost.
- **In Transit:** Data is encrypted using HTTPS. Always enforce secure transfer.
- **Double Encryption:** Some regions/storage types support two layers of encryption for extra protection.

**Exam Tips:**
- Know the difference between Microsoft-managed and customer-managed keys.
- Understand how to enforce HTTPS and when CMK is required.

---

### 🔐 Network Access & Security

- **Firewalls:** Restrict access to trusted networks/IPs.
- **Private Endpoints:** Integrate storage with Azure VNet for private connectivity.
- **Shared Access Signatures (SAS):** Grant granular, time-limited access to storage resources.
- **Identity-based Access:** Use Azure AD for authentication to Azure Files and Blobs.

**Exam Tips:**
- Know how to configure firewalls, VNets, and SAS tokens.
- Understand RBAC and identity-based access for storage.

---

### 🔄 Lifecycle Management

- Automate blob tiering and deletion using lifecycle management policies.
- Example: Move blobs to cool tier after 30 days, delete after 90 days.
- Configure via Azure Portal, CLI, ARM/Bicep, or REST API.

**Exam Tips:**
- Know how to write and apply lifecycle rules for cost optimization.

---

### 🛠️ Storage Explorer & AzCopy

- **Azure Storage Explorer:** GUI tool for managing blobs, files, queues, tables. Supports Azure AD, keys, SAS.
- **AzCopy:** CLI for fast, scriptable data transfer and migration.
  - Upload: `azcopy copy '/local/file.txt' 'https://<account>.blob.core.windows.net/<container>/file.txt?<SAS-token>'`
  - Download: `azcopy copy 'https://<account>.blob.core.windows.net/<container>/file.txt?<SAS-token>' '/local/file.txt'`
  - Sync: `azcopy sync '/local/folder' 'https://<account>.blob.core.windows.net/<container>?<SAS-token>'`

**Exam Tips:**
- Know when to use Storage Explorer vs AzCopy.
- Understand authentication options and troubleshooting for bulk data migration.

---

### 📝 Real-World & Exam Scenarios

- Always choose GPv2 unless premium performance or legacy migration is required.
- Use GZRS/RA-GZRS for mission-critical, globally distributed workloads.
- Apply lifecycle management to optimize costs for infrequently accessed data.
- Use CMK for compliance-driven environments.
- Secure storage with firewalls, private endpoints, and SAS tokens.

---

#### 📘 GZRS (Geo-Zone Redundant Storage)
- Combines **ZRS (zone redundancy)** and **GRS (geo redundancy)**.
- Data is replicated:
  - **3 copies across Availability Zones** in the primary region.
  - **3 more copies** asynchronously to a **paired secondary region**.
- Total = **6 copies of your data**.
- Protects against:
  - Disk or server failure.
  - Datacenter outage.
  - Entire region outage.

**When to use:**
- Mission-critical workloads where you need both **zone-level resilience** and **disaster recovery**.
- Example: Banking or healthcare apps that can’t afford downtime or data loss.

---

#### 📘 RA-GZRS (Read-Access Geo-Zone Redundant Storage)
- Same as **GZRS**, but the **secondary region is readable**.
- Provides **read-only access** to your data in the secondary region.
- Useful for **global applications** or during **regional outages**.

**When to use:**
- Global e-commerce sites serving content from multiple regions.
- Analytics workloads that can query secondary data without affecting the primary region.

---

### ⚡ Standard vs Premium

- **Standard (HDD-based)**  
  - Supports **all redundancy options** (LRS, ZRS, GRS, RA-GRS)  
  - BUT ⚠️ actual availability depends on the **region**.  
    - Some regions show only **LRS + GRS**, or **LRS + ZRS**, etc.  
    - That’s why in your console, you may see only **2 options**.  

- **Premium (SSD-based)**  
  - Supports **LRS and ZRS only** (no GRS/RA-GRS).  
  - Because cross-region replication introduces latency, which breaks the “low latency” promise of Premium.

---

### 📝 Comparison of Redundancy Options
| Type     | Copies | Zones in Primary? | Secondary Region? | Read Secondary? | Protects Against |
|----------|--------|-------------------|-------------------|-----------------|------------------|
| **LRS**  | 3      | ❌ | ❌ | ❌ | Disk/server failure |
| **ZRS**  | 3      | ✅ | ❌ | ❌ | Datacenter outage |
| **GRS**  | 6      | ❌ | ✅ | ❌ | Region outage |
| **RA-GRS** | 6    | ❌ | ✅ | ✅ | Region outage + Read access |
| **GZRS** | 6      | ✅ | ✅ | ❌ | Zone + Region outage |
| **RA-GZRS** | 6   | ✅ | ✅ | ✅ | Zone + Region outage + Read access |

---

### 💡 Exam Tip
- If you see **“best of both worlds”** → think **GZRS** (zones + geo).  
- If the question mentions **read access in secondary region** → answer with **RA-GZRS**.  
- **Premium tier** supports only **LRS & ZRS**, **not** GRS/GZRS types.


### 💡 Real-World Example
- Small test workload → **LRS**  
- Regional web app with AZs → **ZRS**  
- Enterprise DR strategy → **GRS**  
- Global app needing failover reads → **RA-GRS**

---


---

### 🛠️ Practical Uses of RA (Read Access)

1. **Disaster Recovery (DR) Readiness**
 - If the primary region is unavailable, apps can still **read data** from the secondary.
 - Prevents downtime for read-heavy applications.

2. **Global Applications**
 - Users across the world can be directed to the **nearest region** for faster read performance.
 - Example: A media company can stream videos from the secondary region closer to the user.

3. **Analytics & Reporting**
 - Offload heavy read workloads (like BI dashboards or data analysis) to the secondary region.
 - Keeps the primary region focused on write operations.

4. **Testing Secondary Data**
 - Developers can test failover scenarios by connecting apps to the secondary endpoint.
 - Ensures DR strategies actually work.

---

### 💡 Exam & Real-World Tip
- If a question asks:  
“How can you **access your data in secondary region without failover**?” → Answer: **RA-GRS or RA-GZRS**.  
- If a question is about **reducing latency for global users** → RA helps by serving data closer to them.  
- ⚠️ Remember: Secondary is **read-only**. Any **writes must go to primary**.


### 💡 Quick Exam Memory Trick
- **3 copies** in single region = **LRS / ZRS**  
- **6 copies total** (3 local + 3 secondary) = **GRS / RA-GRS / GZRS / RA-GZRS**  
- **RA = Read Access** → you can query the **secondary region**.  

---

### ✅ Best Practices
- Always check **region availability** → not all redundancy options exist in all Azure regions.  
- For **Premium performance tier** → only **LRS** and **ZRS** are supported.  
- For **mission-critical workloads** → prefer **ZRS** or **GZRS** over LRS.  


### ✅ Exam Tip
- If asked: “Which redundancy provides highest durability?” → **RA-GRS**.  
- If asked: “Which redundancy Premium supports?” → **LRS & ZRS only**.  
- If only 2 redundancy options are visible in Portal → It’s due to **region limitations**.


---

## Configure Encryption

### 📘 Encryption at Rest

- **Default Protection**: All Azure Storage data is encrypted at rest using 256-bit AES encryption, managed by Microsoft. This is transparent and automatic—no configuration required for baseline security.
- **Customer-Managed Keys (CMK)**: For regulatory compliance or advanced control, you can use your own keys stored in Azure Key Vault. This allows you to rotate, disable, or audit key usage.
  - **Setup Steps**:
    1. Create an Azure Key Vault and generate a key.
    2. Assign the storage account access to the Key Vault (using a managed identity).
    3. Configure the storage account to use the Key Vault key for encryption.
    4. Optionally, enable key auto-rotation.
- **Double Encryption**: Some regions/storage types support double encryption, layering two independent encryption algorithms for extra protection.
- **Encryption Scope**: You can set encryption scopes at the container or blob level, allowing different keys for different data sets.

### 📘 Encryption in Transit

- **HTTPS Required**: All data transferred to/from Azure Storage should use HTTPS. You can enforce this by setting `Secure transfer required` to `Enabled` on the storage account.
- **SMB Encryption**: For Azure Files, SMB 3.0 encryption can be enabled for secure file share access.

### 🛠️ Pro Tips

- **Audit Key Usage**: Use Azure Key Vault logging to monitor key access and operations.
- **Key Rotation**: Regularly rotate CMKs for compliance; Azure Key Vault supports automatic rotation.
- **Access Control**: Restrict who can manage encryption settings using RBAC and Key Vault policies.

### 💡 Exam & Real-World Tips

- Know the difference between Microsoft-managed and customer-managed keys.
- Understand how to enforce HTTPS and SMB encryption.
- Be aware of compliance scenarios (e.g., GDPR, HIPAA) that require CMK or double encryption.

---

## Manage Data with Storage Explorer & AzCopy

### 📘 Azure Storage Explorer

- **GUI Tool**: Cross-platform desktop application for managing Azure Storage resources (blobs, files, queues, tables).
- **Authentication**: Supports Azure AD, account keys, and SAS tokens.
- **Capabilities**:
  - Browse containers, upload/download files, manage snapshots and soft delete.
  - Set access policies, manage file shares, and configure metadata.
  - Connect to multiple subscriptions and storage accounts.

### 📘 AzCopy

- **CLI Tool**: High-performance command-line utility for bulk data transfer to/from Azure Storage.
- **Authentication**: Supports Azure AD, account keys, and SAS tokens.
- **Capabilities**:
  - Upload/download blobs, files, and directories.
  - Sync local folders with blob containers.
  - Copy data between storage accounts or containers.
  - Resume interrupted transfers and optimize for large datasets.

#### 🛠️ Common AzCopy Commands

```bash
# Upload a file to a blob container
azcopy copy '/path/to/local/file.txt' 'https://<storage-account>.blob.core.windows.net/<container>/file.txt?<SAS-token>' --overwrite=true

# Download a blob to local
azcopy copy 'https://<storage-account>.blob.core.windows.net/<container>/file.txt?<SAS-token>' '/path/to/local/file.txt'

# Sync a local folder to a blob container
azcopy sync '/local/folder' 'https://<storage-account>.blob.core.windows.net/<container>?<SAS-token>'
```

### 🛠️ Pro Tips

- **Bulk Migration**: Use AzCopy for large-scale migrations; it’s faster and scriptable compared to GUI tools.
- **Automation**: Integrate AzCopy into CI/CD pipelines for automated uploads/downloads.
- **SAS Tokens**: Use short-lived SAS tokens for secure, temporary access during transfers.
- **Performance**: AzCopy supports parallelism and can resume failed transfers, making it ideal for unreliable networks.

### 💡 Exam & Real-World Tips

- Know when to use Storage Explorer (GUI, ad-hoc tasks) vs AzCopy (CLI, automation, bulk transfer).
- Understand authentication options and best practices for secure access.
- Be familiar with troubleshooting transfer failures (network, permissions, SAS expiry).

---

az deployment group create --resource-group Azure-Admin-Prep --template-file /workspaces/Azure-Admin-AZ-104/storage/storage.bicep

---

azcopy [command] [arguments] [flags]

---

# 🔹 What is a Shared Access Signature (SAS)?

A **SAS** is a **URI with a query string** that grants **restricted, time-bound access** to Azure Storage resources without exposing the storage account key.

* SAS can apply to: **Blob, File, Queue, Table**.
* SAS includes **permissions**, **start/end time**, **protocols (HTTPS)**, **IP restrictions**.

📌 Exam Tip: SAS is a **delegated access mechanism**. It’s a must-know concept for secure access control in Azure Storage.

---

# 🔹 Types of SAS

1. **Service SAS** – scoped to a specific resource (e.g., one container or blob) [Docs](https://learn.microsoft.com/en-us/rest/api/storageservices/create-service-sas).
2. **Account SAS** – applies to multiple services in a storage account [Docs](https://learn.microsoft.com/en-us/rest/api/storageservices/delegate-access-with-shared-access-signature).
3. **User Delegation SAS** – issued using Microsoft Entra ID (Azure AD) instead of storage keys; more secure [Docs](https://learn.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas).

📌 Exam Tip: **Prefer User Delegation SAS** where possible — avoids using account keys.

---

# 🔹 Anatomy of a SAS Token

Example:

```
?sv=2023-11-03&ss=b&srt=sco&sp=rl&se=2025-09-22T12:00:00Z&st=2025-09-21T00:00:00Z&spr=https&sig=abc123...
```

* `sv` = Storage Service Version
* `ss` = Services (b = blob, f = file, q = queue, t = table)
* `srt` = Resource types (s = service, c = container, o = object)
* `sp` = Permissions (r = read, w = write, d = delete, l = list, etc.)
* `se` = Expiry time
* `st` = Start time
* `spr` = Protocol (https/http, https recommended)
* `sig` = Signature (HMAC)

📌 Exam Tip: Be able to **identify permissions (`sp`) and expiry (`se`)** in a SAS string.

---

# 🔹 How to Create SAS

### 1. **Azure Portal**

* Go to **Storage Account → Security + networking → Shared access signature**.
* Choose:

  * Services (Blob/File/Queue/Table)
  * Resource types
  * Permissions
  * Start & Expiry time
  * Protocol (HTTPS recommended)
* Click **Generate SAS and connection string**.

---

### 2. **Azure CLI**

* **Service SAS**

```bash
az storage container generate-sas \
  --account-name mystorageacct \
  --name mycontainer \
  --permissions rl \
  --expiry 2025-09-22T12:00:00Z \
  --auth-mode key
```

* **User Delegation SAS** (Entra ID-based, more secure) [Docs](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-user-delegation-sas-create-cli):

```bash
az login
az storage container generate-sas \
  --account-name mystorageacct \
  --name mycontainer \
  --permissions rl \
  --expiry 2025-09-22T12:00:00Z \
  --auth-mode login \
  --as-user
```

---

### 3. **PowerShell**

```powershell
New-AzStorageContainerSASToken `
   -Name mycontainer `
   -Permission rwdl `
   -ExpiryTime (Get-Date).AddHours(1) `
   -Context $ctx
```

---

### 4. **Python SDK** (User Delegation SAS) [Docs](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-user-delegation-sas-create-python):

```python
from azure.storage.blob import BlobServiceClient, generate_blob_sas, ResourceTypes, AccountSasPermissions

service_client = BlobServiceClient(account_url="https://mystorageacct.blob.core.windows.net", credential=credential)

udk = service_client.get_user_delegation_key("2025-09-21T00:00:00Z", "2025-09-22T12:00:00Z")

sas = generate_blob_sas(
    account_name="mystorageacct",
    container_name="mycontainer",
    blob_name="myblob.txt",
    user_delegation_key=udk,
    permission="r",
    expiry="2025-09-22T12:00:00Z"
)

print(sas)
```

---

# 🔹 Using a SAS

* **Direct URL**

```
https://mystorageacct.blob.core.windows.net/mycontainer/myblob.txt?<SAS>
```

* **AzCopy**

```bash
azcopy copy "https://mystorageacct.blob.core.windows.net/mycontainer/myblob.txt?<SAS>" .
```

---

# 🔹 Revoking a SAS

* **You cannot revoke an ad-hoc SAS** (until expiry).
* To revoke early: use a **Stored Access Policy** [Docs](https://learn.microsoft.com/en-us/rest/api/storageservices/define-stored-access-policy).

```bash
az storage container policy create \
  --account-name mystorageacct \
  --container-name mycontainer \
  --name readonlypolicy \
  --permissions rl \
  --expiry 2025-09-22T12:00:00Z
```

Then generate SAS linked to that policy. Deleting/updating the policy **invalidates all SAS tokens tied to it**.

📌 Exam Tip: **Stored Access Policies = revocation & reusability**.

---

# 🔹 Best Practices (exam must-knows)

* Use **User Delegation SAS** with Microsoft Entra ID where possible.
* Always use **HTTPS only** (`spr=https`).
* Apply **least privilege permissions** (only what’s needed).
* Keep **expiry short**.
* Use **Stored Access Policies** if revocation is required.
* Avoid embedding SAS tokens in code — use **Key Vault** or **Azure Managed Identities** instead.

---

---

## 📘 Main Topic: Configure firewalls and VNets for Storage

We’ll split into these **sub-topics**:

1. **Default network access to storage accounts**
2. **Configure firewall rules (IP-based access)**
3. **Configure VNet service endpoints for storage**
4. **Configure Private Endpoints (Private Link)**
5. **Differences: Service Endpoints vs Private Endpoints**
6. **Testing & troubleshooting network restrictions**
7. **Best practices & exam tips**

---

### 🔹 Sub-Topic 1: Default network access to storage accounts

#### 1. Concept

* By default, **storage accounts allow access from all networks**.
* For security, you can restrict access so only:

  * **Selected IP ranges** (firewall rules).
  * **Specific Virtual Networks (VNets)**.
  * **Private Endpoints** (preferred for production).

This is controlled under:
**Azure Portal → Storage Account → Networking → Firewalls and virtual networks**.

---

#### 2. Options in “Networking”

* **All networks** – anyone on the internet can access (default, less secure).
* **Selected networks** – restrict by firewall rules (IP ranges) or VNets.
* **Disabled** – no access except via trusted Microsoft services or Private Endpoint.

---

#### 3. Key Exam Points

* **By default = All networks allowed**.
* Switching to **Selected networks** immediately blocks everything except:

  * Explicit IP addresses you add.
  * VNets you configure.
  * Private endpoints (if configured).
* “**Allow trusted Microsoft services**” = lets services like Azure Backup, Azure Monitor, etc. bypass firewall (important for exam).

---

#### 4. Azure Portal Steps

1. Go to **Storage Account** → **Networking**.
2. Under **Public network access**, choose **Selected networks**.
3. Save.

Now, only IPs/VNets you add will have access.

---

#### 5. CLI Example

Check current network rules:

```bash
az storage account network-rule list \
  --resource-group MyRG \
  --account-name mystorageacct
```

Deny all by default:

```bash
az storage account update \
  --resource-group MyRG \
  --name mystorageacct \
  --default-action Deny
```

---

✅ **Exam Tip:** The phrase **“default action = Allow/Deny”** is critical. If `Deny` is set, access must come from **firewall IP rules, VNet rules, or private endpoints**.

---

## 🔹 Sub-Topic 2: Configure Firewall Rules (IP-based Access)

### 1. Concept

* A **storage account firewall** lets you restrict access to **specific public IP addresses or IP ranges**.
* Useful when:

  * You want developers/admins to connect only from office/home IPs.
  * You don’t want the whole internet to hit your storage account.

📌 This is **layer 1 restriction** — IP-based filtering before VNet or Private Endpoint rules.

---

### 2. How it Works

* You set `default-action = Deny` (blocks everything).
* Then you **add IP rules**:

  * Single IP: `20.30.40.50`
  * Range: `20.30.40.0/24`
* Only these IPs can reach the storage account.
* Any other IP is blocked at the firewall level.

---

### 3. Azure Portal Steps

1. Go to **Storage Account → Networking**.
2. Under **Firewalls and virtual networks**, select **Selected networks**.
3. Under **Firewall**, add:

   * Specific IP (e.g., your public home IP).
   * Range (e.g., `10.0.0.0/16`).
4. Save.
5. Test: Try accessing the blob from an unauthorized IP → access denied.

---

### 4. CLI Commands

Set default deny:

```bash
az storage account update \
  --resource-group MyRG \
  --name mystorageacct \
  --default-action Deny
```

Add a firewall rule for single IP:

```bash
az storage account network-rule add \
  --resource-group MyRG \
  --account-name mystorageacct \
  --ip-address 20.30.40.50
```

Add a firewall rule for range:

```bash
az storage account network-rule add \
  --resource-group MyRG \
  --account-name mystorageacct \
  --ip-address 20.30.40.0/24
```

---

### 5. PowerShell Example

```powershell
# Block all by default
Update-AzStorageAccountNetworkRuleSet `
   -ResourceGroupName MyRG `
   -Name mystorageacct `
   -DefaultAction Deny

# Add IP rule
Add-AzStorageAccountNetworkRule `
   -ResourceGroupName MyRG `
   -Name mystorageacct `
   -IPAddressOrRange 20.30.40.50
```

---

### 6. Key Exam Notes

* IP firewall rules apply to **IPv4** only (IPv6 is not supported yet for firewall rules).
* If `default-action = Deny`, you must add at least:

  * An IP rule, OR
  * A VNet rule, OR
  * A Private Endpoint.
* **Trusted Microsoft services** (like Azure Backup, Monitor) can bypass firewall if you enable the checkbox.
* **Exam trap**: If you block all and forget to add your current client IP, you’ll lock yourself out.

---

## 🔹 Sub-Topic 3: Configure VNet Service Endpoints for Storage

### 1. Concept

* **Service Endpoints** extend your VNet’s private address space into Azure services.
* When you enable a **VNet service endpoint** for Azure Storage:

  * Traffic from your VNet to the storage account **goes over Azure backbone** (not the public internet).
  * You can restrict the storage account to **only accept traffic from that VNet/subnet**.
* This provides **better security** than just IP firewall rules.

---

### 2. Key Characteristics

* Works with **public endpoint** of storage account, not private IP.
* Restriction is **VNet/subnet-level**, not IP-level.
* Traffic still uses the storage account’s **public FQDN** (like `mystorageacct.blob.core.windows.net`) — but it comes from the **VNet service endpoint**.
* You can allow multiple VNets/subnets.

---

### 3. Azure Portal Steps

1. Go to **Storage Account → Networking**.
2. Under **Firewalls and virtual networks**, choose **Selected networks**.
3. Click **+ Add existing virtual network**.
4. Select subscription, VNet, and subnet.
5. Save.
6. Test:

   * A VM inside the VNet can access the storage account.
   * A VM outside the VNet gets **403 (forbidden)**.

---

### 4. CLI Example

Enable service endpoint on a subnet:

```bash
az network vnet subnet update \
  --resource-group MyRG \
  --vnet-name MyVNet \
  --name MySubnet \
  --service-endpoints Microsoft.Storage
```

Add the VNet rule to storage account:

```bash
az storage account network-rule add \
  --resource-group MyRG \
  --account-name mystorageacct \
  --vnet-name MyVNet \
  --subnet MySubnet
```

---

### 5. PowerShell Example

```powershell
# Enable service endpoint
Set-AzVirtualNetworkSubnetConfig `
   -VirtualNetwork $vnet `
   -Name "MySubnet" `
   -AddressPrefix "10.0.1.0/24" `
   -ServiceEndpoint Microsoft.Storage

# Apply rule to storage
Add-AzStorageAccountNetworkRule `
   -ResourceGroupName MyRG `
   -Name mystorageacct `
   -VirtualNetworkResourceId $subnet.Id
```

---

### 6. Exam Notes

* **Service Endpoints vs Firewall**:

  * Firewall restricts by IP.
  * Service Endpoints restrict by **VNet/subnet identity**.
* **Still uses public IP** → not a private IP address.
* Must **enable service endpoint on the subnet** before adding it to storage firewall.
* Service endpoints **don’t work across regions** (storage account + VNet must be in same region).
* When `default-action = Deny` → only allowed VNets can access.

---

## 🔹 Sub-Topic 4: Configure Private Endpoints (Private Link for Storage)

### 1. Concept

* A **Private Endpoint** assigns a **private IP address from your VNet** to your storage account.
* Instead of going through the **public endpoint**, traffic goes through **Azure Private Link** over the Microsoft backbone.
* This means:

  * No exposure to the internet.
  * Storage account is reachable only from within your VNet (or connected VNets/on-premises via VPN/ExpressRoute).

✅ **Most secure option** for production.

---

### 2. Key Characteristics

* A **Private Endpoint = NIC** inside your subnet.
* Storage account gets a **private FQDN mapping**:

  ```
  mystorageacct.privatelink.blob.core.windows.net
  ```
* Public DNS for `mystorageacct.blob.core.windows.net` resolves to the **private IP** if you configure DNS correctly.
* Supports all services: **Blob, File, Queue, Table** (but you must create one private endpoint per service).

---

### 3. Azure Portal Steps

1. Go to **Storage Account → Networking → Private endpoint connections**.
2. Click **+ Private endpoint**.
3. Select subscription, resource group, and storage account.
4. Choose **Target sub-resource**:

   * `blob` (for blob service)
   * `file` (for file shares)
   * `queue`
   * `table`
5. Select VNet and subnet.
6. (Optional) Configure **Private DNS zone** `privatelink.blob.core.windows.net`.
7. Create.
8. Test:

   * VM in VNet → access works via private IP.
   * Outside VNet → denied.

---

### 4. CLI Example

Create private endpoint:

```bash
az network private-endpoint create \
  --name MyPrivateEP \
  --resource-group MyRG \
  --vnet-name MyVNet \
  --subnet MySubnet \
  --private-connection-resource-id $(az storage account show \
       --name mystorageacct \
       --resource-group MyRG \
       --query id -o tsv) \
  --group-id blob \
  --connection-name mystorageacct-privatelink
```

Configure DNS:

```bash
az network private-dns zone create \
  --resource-group MyRG \
  --name privatelink.blob.core.windows.net

az network private-dns link vnet create \
  --resource-group MyRG \
  --zone-name privatelink.blob.core.windows.net \
  --name MyDNSLink \
  --virtual-network MyVNet \
  --registration-enabled false

az network private-dns record-set a add-record \
  --resource-group MyRG \
  --zone-name privatelink.blob.core.windows.net \
  --record-set-name mystorageacct \
  --ipv4-address 10.0.0.5
```

---

### 5. PowerShell Example

```powershell
New-AzPrivateEndpoint `
   -Name MyPrivateEP `
   -ResourceGroupName MyRG `
   -Location eastus `
   -Subnet $subnet `
   -PrivateLinkServiceConnection @(New-AzPrivateLinkServiceConnection `
       -Name mystorageacct-privatelink `
       -PrivateLinkServiceId $storage.Id `
       -GroupId "blob")
```

---

### 6. Exam Notes

* **Private Endpoints vs Service Endpoints**:

  * Service Endpoint → still uses **public IP**, locked to VNet.
  * Private Endpoint → uses **private IP**, no public internet exposure.
* **DNS is critical** — if not configured, clients may still try to hit the public endpoint.
* You need **1 private endpoint per sub-resource** (blob, file, queue, table).
* Costs: Private endpoints incur **extra charges** vs service endpoints.
* **Trusted Microsoft services** bypass is **not needed** with private endpoints (traffic doesn’t leave MS backbone).

---

| Feature                   | **Service Endpoint**                                      | **Private Endpoint (Private Link)**                                                 |
| ------------------------- | --------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Network traffic**       | Goes over **public endpoint** but from **VNet source IP** | Goes over **private IP** in your VNet (completely private)                          |
| **IP exposure**           | Uses storage account public IP                            | Uses **private IP from VNet subnet**                                                |
| **DNS**                   | No special DNS needed                                     | Requires **private DNS zone** to resolve FQDN to private IP                         |
| **Scope**                 | Restrict access **VNet/subnet**                           | Restrict access **VNet/subnet** + no internet exposure                              |
| **Security**              | Traffic is secured but still over public endpoint         | Traffic **never goes to public internet**                                           |
| **Cross-region**          | Works only within the same region                         | Works within same region; can combine with **Global VNet Peering** for multi-region |
| **Supported services**    | Blob, File, Queue, Table                                  | Blob, File, Queue, Table                                                            |
| **Resource per endpoint** | VNet/subnet-wide                                          | **1 private endpoint per sub-resource** (e.g., 1 for blob, 1 for file)              |
| **Exam focus / usage**    | Quick VNet restriction, cheaper                           | High-security, production-ready, zero public exposure                               |






  
