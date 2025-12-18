# AZ-104 — SECTION 2.0

## AZURE STORAGE FOUNDATIONS (VERY IN-DEPTH)

This section explains **why storage questions behave the way they do in the exam**.
If 2.0 is strong, **2.1–2.5 become mechanical**.

We will split **2.0 into four sub-sections**:

* **2.0A — What Azure Storage really is (platform view)**
* **2.0B — Control plane vs Data plane (MOST IMPORTANT)**
* **2.0C — Storage security model (identity, keys, SAS)**
* **2.0D — How exam questions are constructed from these rules**

---

## SECTION 2.0A

# What Azure Storage REALLY Is (Platform Truth)

---

## 1️⃣ Azure Storage — Exam Definition (Exact Meaning)

Azure Storage is:

* A **platform service (PaaS)**
* Exposed via **REST endpoints**
* Globally available
* Designed for **massive scale and durability**

Azure Storage is **NOT**:

* A filesystem replacement (by default)
* A VM-attached disk
* A single service

It is a **collection of services behind one account boundary**.

---

## 2️⃣ Storage Is Always Accessed Over HTTPS

Every storage interaction is:

* REST-based
* HTTPS
* Authenticated per request

There is **no concept of “logged in session”** like a VM.

This is why:

* Tokens matter
* Time limits matter
* Network rules matter

---

## 3️⃣ Storage Is a Multi-Tenant Platform

Azure Storage:

* Runs on shared infrastructure
* Uses **logical isolation**, not physical servers
* Relies heavily on:

  * Identity
  * Tokens
  * Encryption

👉 This explains why **identity and networking are heavily tested** in AZ-104 storage questions.

---

## SECTION 2.0B

# Control Plane vs Data Plane (MOST IMPORTANT STORAGE CONCEPT)

> **This single concept explains ~60% of storage exam failures.**

---

## 4️⃣ Two Completely Different Planes

Azure Storage has **two independent planes**:

| Plane                | What it controls              |
| -------------------- | ----------------------------- |
| **Management Plane** | Storage account configuration |
| **Data Plane**       | Actual data access            |

They are evaluated **separately**.

---

## 5️⃣ Management Plane (ARM Layer)

Handled by:

* Azure Resource Manager (ARM)
* Azure Portal
* Azure CLI / PowerShell

Examples:

* Create storage account
* Change replication
* Configure firewall
* Enable soft delete

🔐 Controlled by:

* **Azure RBAC (management roles)**

Example roles:

* Contributor
* Storage Account Contributor

---

## 6️⃣ Data Plane (Storage Service Layer)

Handled by:

* Blob service
* File service
* Queue service
* Table service

Examples:

* Upload blob
* Read file
* Delete container
* List objects

🔐 Controlled by:

* **Data-plane authorization**

  * Entra ID data roles
  * SAS
  * Access keys

---

## 🔴 EXAM GOLDEN RULE

> **Having RBAC access to the storage account does NOT guarantee access to data**

This is intentional and heavily tested.

---

## 7️⃣ Classic Exam Trap (Understand WHY)

> User has **Contributor** role on a storage account but cannot upload blobs.

Why?

* Contributor = management plane
* Uploading blob = data plane
* Missing **Storage Blob Data Contributor**

---

## SECTION 2.0C

# Storage Security Model (Identity, Keys, SAS)

---

## 8️⃣ Azure Storage Supports MULTIPLE Auth Models

Azure Storage supports **four authentication mechanisms**:

| Method                        | Plane            |
| ----------------------------- | ---------------- |
| Azure RBAC (Mgmt roles)       | Management plane |
| Entra ID (Data roles)         | Data plane       |
| Account Access Keys           | Data plane       |
| Shared Access Signature (SAS) | Data plane       |

They **co-exist**, they do NOT replace each other.

---

## 9️⃣ Identity-Based Access (Modern & Preferred)

Using:

* Microsoft Entra ID
* Managed identities
* Service principals

Requires:

* **Storage data roles**, not normal RBAC roles

Examples:

* Storage Blob Data Reader
* Storage Blob Data Contributor
* Storage File Data SMB Share Contributor

👉 These roles are **different from Contributor**.

---

## 1️⃣0️⃣ Key-Based Access (Legacy but Exam-Tested)

Access keys:

* Grant **full access** to data plane
* Bypass RBAC
* Are shared secrets

Two keys exist so you can:

* Rotate without downtime

🔴 Exam tone:

> Keys work, but they are **not least-privilege**

---

## 1️⃣1️⃣ SAS (Delegated Access)

Shared Access Signature:

* Time-bound
* Permission-bound
* Resource-scoped

Used when:

* Temporary access is required
* External access is needed
* Identity is not practical

---

## 1️⃣2️⃣ Security Priority Order (EXAM THINKING)

When Azure evaluates a request:

1. Network access (firewall / private endpoint)
2. Authentication method
3. Authorization (roles / SAS / key)
4. Data operation

Fail at any step → access denied.

---

## SECTION 2.0D

# How AZ-104 Storage Questions Are BUILT

This is critical.

---

## 1️⃣3️⃣ Microsoft Uses “Conflict Scenarios”

Typical exam pattern:

* RBAC looks correct
* But access still fails

Your job:

* Identify **which plane** is blocking

---

## 1️⃣4️⃣ Plane-Based Question Mapping

| Question Mentions           | Think            |
| --------------------------- | ---------------- |
| Create / configure / enable | Management plane |
| Upload / download / read    | Data plane       |
| Firewall / private endpoint | Network gate     |
| Temporary access            | SAS              |
| Azure service access        | Managed Identity |

---

## 1️⃣5️⃣ Most Common Wrong Assumptions

❌ “Contributor can upload blobs”
❌ “RBAC covers everything”
❌ “If portal works, data access works”
❌ “Keys are disabled by RBAC”

AZ-104 is designed to catch these assumptions.

---

## 1️⃣6️⃣ FOUNDATION LOCK-IN CHECK (VERY IMPORTANT)

Answer slowly, but confidently:

1. Is uploading a blob a management-plane or data-plane operation?
2. Can RBAC alone allow blob uploads?
3. Which plane controls firewall rules?
4. Can access keys bypass RBAC?
5. Are storage requests stateful or per-request?

If any answer is unclear → we **do not move forward**.

---
