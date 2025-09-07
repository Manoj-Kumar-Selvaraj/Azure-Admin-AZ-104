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

### 💡 Real-World Example
- Small test workload → **LRS**  
- Regional web app with AZs → **ZRS**  
- Enterprise DR strategy → **GRS**  
- Global app needing failover reads → **RA-GRS**

---

### ✅ Exam Tip
- If asked: “Which redundancy provides highest durability?” → **RA-GRS**.  
- If asked: “Which redundancy Premium supports?” → **LRS & ZRS only**.  
- If only 2 redundancy options are visible in Portal → It’s due to **region limitations**.



  
