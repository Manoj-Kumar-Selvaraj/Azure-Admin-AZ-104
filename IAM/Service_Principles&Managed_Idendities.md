---

# AZ-104 MASTER TRAINING

## SESSION 1.2 — SERVICE PRINCIPALS & MANAGED IDENTITIES (VERY IN-DEPTH)

This session will be split into **three mandatory parts**:

* **1.2A — Why these identities exist (conceptual truth)**
* **1.2B — Service Principals (full lifecycle, exam traps)**
* **1.2C — Managed Identities (system vs user-assigned, when to choose what)**

Nothing will be skipped.

---

# SESSION 1.2A

## WHY SERVICE PRINCIPALS & MANAGED IDENTITIES EXIST

---

## 1️⃣ The Core Problem Azure Had

Azure faced a fundamental issue:

> **Non-human workloads need to authenticate securely**

Examples:

* App Service accessing Storage
* VM accessing Key Vault
* Automation script deploying resources
* CI/CD pipeline running Terraform

### BAD OLD WAY (EXAM CALLS THIS OUT)

* Hard-coded usernames/passwords
* Stored secrets in code
* IAM users (AWS analogy)

❌ Insecure
❌ Non-rotated
❌ Not auditable

---

## 2️⃣ Azure’s Solution

Azure introduced **application identities**:

| Identity              | Purpose                        |
| --------------------- | ------------------------------ |
| **Service Principal** | App / automation identity      |
| **Managed Identity**  | Azure-managed service identity |

These are:

* **Non-human**
* **First-class Entra ID identities**
* **Fully RBAC compatible**

---

## 3️⃣ CRITICAL EXAM RULE (MEMORIZE)

> **If a resource needs to access another resource → it must use an identity**

No exceptions.

---

## 4️⃣ Identity Comparison (High-Level)

| Identity          | Human? | Password? | Azure Managed? |
| ----------------- | ------ | --------- | -------------- |
| User              | Yes    | Yes       | No             |
| Service Principal | No     | Yes/Cert  | No             |
| Managed Identity  | No     | No        | **Yes**        |

---

# SESSION 1.2B

## SERVICE PRINCIPALS — COMPLETE DEEP DIVE

This is **the most misunderstood object in AZ-104**.

---

## 5️⃣ What a Service Principal REALLY Is

A **Service Principal (SP)** is:

* An **identity for an application**
* Created in **Microsoft Entra ID**
* Used by:

  * Applications
  * Automation
  * CI/CD pipelines

Think of it as:

> **“A user account for apps”**

---

## 6️⃣ IMPORTANT DISTINCTION (EXAM LOVES THIS)

There are **three related objects** (people confuse these badly):

| Object                | Exists Where | Purpose                  |
| --------------------- | ------------ | ------------------------ |
| App Registration      | Entra ID     | App definition           |
| Application Object    | Entra ID     | Global app template      |
| **Service Principal** | Entra ID     | Tenant-specific identity |

### Exam Simplification

* **App Registration creates a Service Principal**
* **RBAC is assigned to the Service Principal**

---

## 7️⃣ Service Principal Authentication Methods

A Service Principal authenticates using:

1. **Client Secret** (password)
2. **Certificate**
3. **Federated Identity (OIDC)**

⚠️ **EXAM TREND (VERY IMPORTANT)**
Microsoft now prefers:

* **Federated credentials**
* **NO secrets**

---

## 8️⃣ Typical Service Principal Use Cases (Exam Patterns)

| Scenario                       | Correct Identity         |
| ------------------------------ | ------------------------ |
| Terraform deploying Azure      | Service Principal        |
| GitHub Actions accessing Azure | Service Principal (OIDC) |
| Script running outside Azure   | Service Principal        |
| Legacy automation              | Service Principal        |

---

## 9️⃣ RBAC with Service Principals

Service Principals:

* Can be assigned roles
* At any scope:

  * Management Group
  * Subscription
  * Resource Group
  * Resource

Example:

```
SP → Contributor → Subscription
```

---

## 🔟 EXAM TRAP — WHAT SPs ARE NOT

❌ Service Principal is NOT:

* A VM
* A resource
* A managed identity
* A user

If the question says:

> “Application running **outside Azure**”

👉 **Service Principal**

---

## 1️⃣1️⃣ Security Risks (Exam Awareness)

Bad practices:

* Long-lived client secrets
* Secrets in code
* Broad RBAC (Owner)

Best practice:

* Least privilege
* Certificate or OIDC auth
* Scoped RBAC

---

# SESSION 1.2C

## MANAGED IDENTITIES — COMPLETE DEEP DIVE

---

## 1️⃣2️⃣ Why Managed Identities Exist

Service Principals still require:

* Secret management
* Rotation
* Secure storage

Azure solved this with:

> **Managed Identities**

---

## 1️⃣3️⃣ What a Managed Identity REALLY Is

A **Managed Identity** is:

* A **Service Principal managed by Azure**
* Automatically created in Entra ID
* **No credentials exposed**

Azure:

* Creates it
* Rotates secrets
* Deletes it

---

## 1️⃣4️⃣ Types of Managed Identities (EXAM CRITICAL)

### System-Assigned Managed Identity (SAMI)

* Tied to **ONE resource**
* Lifecycle = resource lifecycle
* Deleted when resource is deleted

Example:

```
VM → System-assigned MI
```

---

### User-Assigned Managed Identity (UAMI)

* Created as **separate Azure resource**
* Can be attached to **multiple resources**
* Independent lifecycle

Example:

```
UAMI → VM + App Service
```

---

## 1️⃣5️⃣ Comparison (MEMORIZE)

| Feature        | System-Assigned | User-Assigned |
| -------------- | --------------- | ------------- |
| Lifecycle      | Resource-bound  | Independent   |
| Reusable       | ❌ No            | ✅ Yes         |
| RBAC           | ✅ Yes           | ✅ Yes         |
| Identity reuse | ❌ No            | ✅ Yes         |

---

## 1️⃣6️⃣ EXAM DECISION RULE (VERY IMPORTANT)

| Scenario                                | Choose          |
| --------------------------------------- | --------------- |
| One resource, simple access             | System-assigned |
| Multiple resources share identity       | User-assigned   |
| Identity must survive resource deletion | User-assigned   |

---

## 1️⃣7️⃣ Managed Identity + RBAC Flow

1. Enable Managed Identity
2. Azure creates Service Principal
3. Assign RBAC role
4. Resource uses token automatically

NO secrets.
NO passwords.

---

## 1️⃣8️⃣ EXAM-STYLE SCENARIOS (HIGH VALUE)

### Scenario 1

> VM needs access to Key Vault. No secrets allowed.

✅ **System-assigned managed identity**

---

### Scenario 2

> Multiple App Services need access to the same Storage Account.

✅ **User-assigned managed identity**

---

### Scenario 3

> CI/CD pipeline running outside Azure.

✅ **Service Principal**

---

## 1️⃣9️⃣ WHY CANDIDATES FAIL SESSION 1.2

They:

* Confuse SPs with managed identities
* Use SPs when MI is required
* Ignore lifecycle implications
* Miss “outside Azure” wording

Microsoft **intentionally words questions to trap this**.

---

## 2️⃣0️⃣ LOCK-IN CHECK (DO NOT SKIP)

Answer **YES / NO** (no thinking):

1. Is a managed identity a type of service principal?
2. Can a system-assigned MI be reused across resources?
3. Can a service principal authenticate without secrets?
4. Does Azure rotate managed identity credentials automatically?

---
