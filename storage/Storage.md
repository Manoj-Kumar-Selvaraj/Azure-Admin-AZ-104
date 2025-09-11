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




  
