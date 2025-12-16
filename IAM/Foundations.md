# AZ-104 MASTER TRAINING

## SESSION 1.0 — AZURE IDENTITY & GOVERNANCE FOUNDATIONS

*(This session alone explains ~30% of later questions)*

---

# SESSION 1.0A

## What Azure REALLY Means by Identity (Exam Perspective)

---

## 1️⃣ Identity — Azure’s First Principle

In Azure, **everything starts with identity**.

> Azure **never** grants access to “things”.
> Azure grants access only to **identities**.

### An identity in Azure is:

* A **directory object**
* Issued by **Microsoft Entra ID**
* With a unique **Object ID**

---

## 2️⃣ What IS and IS NOT an Identity (Exam Elimination Rule)

### ✅ Azure Identity Objects

* User
* Group
* Service Principal
* Managed Identity

### ❌ NOT Identities

* Virtual Machine
* Subscription
* Resource Group
* IP address
* VNet

> If it cannot authenticate → it is NOT an identity.

---

## 3️⃣ Why AZ-104 Tests This Early

Because:

* RBAC works only with identities
* Policies apply **to scopes**, not identities
* Authentication happens **before** authorization

If identity fails → **no Azure question matters**

---

## 4️⃣ Authentication vs Authorization (ZERO CONFUSION ALLOWED)

### Authentication

**Question answered:**

> *Who are you?*

Handled by:

* **Microsoft Entra ID**

Examples:

* Username/password
* MFA
* Conditional Access

---

### Authorization

**Question answered:**

> *What are you allowed to do?*

Handled by:

* Azure RBAC
* Azure Policy
* Resource Locks

---

### 🔥 EXAM TRAP

> “User can log in but cannot access a resource”

✅ Authentication works
❌ Authorization missing

---

# SESSION 1.0B

## Microsoft Entra ID (Tenant) — The Security Boundary

---

## 5️⃣ What Microsoft Entra ID ACTUALLY Is

**Microsoft Entra ID** is:

* A **cloud-based identity provider**
* Global and region-independent
* The **security boundary** for Azure

It is NOT:

* A VM
* A domain controller
* A network service

---

## 6️⃣ Tenant — Precise Exam Definition

A **tenant** is:

* A **dedicated instance** of Entra ID
* Representing **one organization**
* The **root identity boundary**

```
Tenant = Identity + Security boundary
```

---

## 7️⃣ Tenant Facts (EXAM GUARANTEED)

* Every tenant has:

  * Tenant ID (GUID)
  * Default domain (*.onmicrosoft.com)
* A tenant can have:

  * Multiple subscriptions
* A subscription can belong to:

  * **Only ONE tenant**

---

## 8️⃣ Critical Exam Rule

> **Users exist in the tenant, not in subscriptions**

So:

* You can create users **without any subscription**
* Billing ≠ identity

---

# SESSION 1.0C

## Azure Governance Hierarchy (EXAM-ACCURATE)

---

## 9️⃣ THE ONLY CORRECT AZURE HIERARCHY

Memorize this. No alternatives.

```
Microsoft Entra ID (Tenant)
│
└── Management Groups
    │
    └── Subscriptions
        │
        └── Resource Groups
            │
            └── Resources
```

---

## 1️⃣0️⃣ What Each Level REALLY Does

| Level            | Purpose                   |
| ---------------- | ------------------------- |
| Tenant           | Identity & authentication |
| Management Group | Governance scope          |
| Subscription     | Billing & isolation       |
| Resource Group   | Lifecycle                 |
| Resource         | Service                   |

---

## 1️⃣1️⃣ Inheritance Rules (EXAM HEAVY)

* **RBAC** → Inherits downward
* **Azure Policy** → Inherits downward
* **Resource Locks** → Inherit downward
* **Entra ID** → Does NOT inherit (auth only)

```
MG → Sub → RG → Resource
```

---

## 1️⃣2️⃣ Management Groups (Why They Exist)

Used to:

* Apply policy across subscriptions
* Apply RBAC across subscriptions
* Enforce org-wide governance

They do:

* ❌ No billing
* ❌ No identity
* ❌ No resources

---

## 1️⃣3️⃣ Subscription (Why Exam Loves It)

Subscriptions:

* Are **billing containers**
* Provide isolation
* Are RBAC scopes

A user with **Owner** at subscription:

* Can create resources
* Can assign RBAC

---

## 1️⃣4️⃣ EXAM SCENARIOS (FOUNDATIONAL)

### Question 1

> You must apply a policy across 5 subscriptions.

✅ Assign policy at **Management Group**

---

### Question 2

> A user exists but sees no subscriptions.

✅ No RBAC assignment

---

### Question 3

> Where does authentication happen?

✅ Microsoft Entra ID

---

## 1️⃣5️⃣ WHY PEOPLE FAIL SESSION 1.0

They:

* Mix tenant with subscription
* Think management groups hold identity
* Assume resources authenticate

AZ-104 punishes this instantly.

---

## 1️⃣6️⃣ LOCK-IN CHECK (DO NOT SKIP)

Answer **YES / NO** (slowly):

1. Can a tenant exist without subscriptions?
2. Can a subscription belong to multiple tenants?
3. Does RBAC inherit upward?
4. Do management groups authenticate users?

---
