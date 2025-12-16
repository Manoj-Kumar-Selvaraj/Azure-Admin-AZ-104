# AZ-104 MASTER TRAINING

## SESSION 1.4 — AZURE GOVERNANCE

**(Azure Policy, Resource Locks, Tags, Subscriptions, Management Groups)**

This session is split into **five sub-sessions** to avoid missing anything:

* **1.4A — Governance mindset & control layers**
* **1.4B — Azure Policy (deepest exam topic here)**
* **1.4C — Resource Locks (simple but tricky)**
* **1.4D — Tags (lightweight governance, exam traps)**
* **1.4E — Subscriptions & Management Groups (governance angle)**

---

## SESSION 1.4A

# Governance — HOW MICROSOFT THINKS

---

## 1️⃣ What “Governance” Means in Azure (Exam Definition)

Governance answers this question:

> **“How do we ensure Azure resources comply with organizational rules?”**

Governance is about:

* Standardization
* Compliance
* Cost control
* Risk reduction

It is **NOT**:

* Authentication
* Authorization
* Networking
* Security tooling

---

## 2️⃣ Governance vs RBAC (VERY IMPORTANT)

| Area               | RBAC        | Governance      |
| ------------------ | ----------- | --------------- |
| Controls           | WHO can act | WHAT is allowed |
| Identity-based     | Yes         | No              |
| Enforces standards | No          | Yes             |
| Explicit deny      | No          | Yes (Policy)    |

👉 **RBAC gives permission**
👉 **Governance enforces rules**

---

## 3️⃣ Azure Governance Control Stack (MEMORIZE)

```
Azure Policy
↓
Resource Locks
↓
Tags
↓
RBAC (parallel, not part of governance)
```

Each solves a **different problem**.

---

## SESSION 1.4B

# AZURE POLICY — VERY DEEP DIVE (EXAM HEAVY)

---

## 4️⃣ What Azure Policy REALLY Is

Azure Policy is:

* A **rule engine**
* Evaluated by **Azure Resource Manager**
* Enforces **desired state**

Azure Policy:

* Can **deny**
* Can **audit**
* Can **modify**
* Can **deploy resources**

---

## 5️⃣ Policy vs RBAC (EXAM ELIMINATION RULE)

If question says:

* “Prevent”
* “Enforce”
* “Ensure only”

👉 **Azure Policy**

If question says:

* “Who can”
* “Grant access”

👉 **RBAC**

---

## 6️⃣ Policy Components (INTERNAL MODEL)

Azure Policy has **four core parts**:

| Component  | Purpose                |
| ---------- | ---------------------- |
| Definition | The rule               |
| Assignment | Where it applies       |
| Parameters | Custom values          |
| Initiative | Collection of policies |

---

## 7️⃣ Policy Effects (THIS IS EXAM GOLD)

### MOST IMPORTANT EFFECTS

| Effect                | Meaning               |
| --------------------- | --------------------- |
| **Deny**              | Block creation/update |
| **Audit**             | Log non-compliance    |
| **AuditIfNotExists**  | Audit missing config  |
| **DeployIfNotExists** | Auto-remediate        |
| **Modify**            | Change resource       |

---

### EXAM TRAP

> “Ensure all VMs have monitoring enabled”

✅ **DeployIfNotExists**

❌ Deny
❌ Audit only

---

## 8️⃣ Policy Evaluation Timing (CRITICAL)

Azure Policy is evaluated:

* **During resource creation**
* **During resource update**
* **On compliance scan**

It is **NOT retroactive** unless remediation is used.

---

## 9️⃣ Policy Scope & Inheritance

Policies can be assigned at:

```
Management Group
Subscription
Resource Group
```

They **inherit downward**, just like RBAC.

---

## 🔟 Initiatives (Policy Sets)

An **initiative** is:

* A collection of policies
* Used for compliance frameworks

Examples:

* ISO 27001
* PCI-DSS
* Azure Security Benchmark

👉 Exam prefers **Initiatives for enterprise compliance**

---

## 1️⃣1️⃣ Policy Remediation (EXAM FAVORITE)

* Uses **Managed Identity**
* Applies DeployIfNotExists or Modify
* Fixes existing non-compliant resources

⚠️ Requires:

* Proper RBAC permissions
* Remediation task execution

---

## SESSION 1.4C

# RESOURCE LOCKS — SMALL BUT DEADLY

---

## 1️⃣2️⃣ What Resource Locks REALLY Do

Resource locks:

* Protect resources from **accidental changes**
* Override **ALL RBAC roles**

Even **Owner** cannot bypass a lock.

---

## 1️⃣3️⃣ Lock Types (ONLY TWO)

| Lock         | Effect      |
| ------------ | ----------- |
| ReadOnly     | No changes  |
| CanNotDelete | No deletion |

---

## 1️⃣4️⃣ Lock Scope & Inheritance

Locks can be applied at:

```
Subscription
Resource Group
Resource
```

They **inherit downward**.

---

## 1️⃣5️⃣ EXAM TRAP

> “User is Owner but cannot delete resource”

✅ **Resource Lock**

❌ RBAC
❌ Policy

---

## SESSION 1.4D

# TAGS — GOVERNANCE LITE (BUT EXAM-TESTED)

---

## 1️⃣6️⃣ What Tags Are (AND ARE NOT)

Tags are:

* Key–value metadata
* Used for:

  * Cost tracking
  * Organization
  * Automation

Tags are NOT:

* Security controls
* Access controls
* Enforcement mechanisms

---

## 1️⃣7️⃣ Tag Behavior (IMPORTANT DETAILS)

* Tags:

  * Apply to resources and RGs
  * ❌ Do NOT inherit automatically
* Resource Group tags:

  * Are NOT inherited by resources

---

## 1️⃣8️⃣ Enforcing Tags (EXAM PATTERN)

> “Ensure all resources have a CostCenter tag”

✅ Azure Policy (Deny or Modify)

❌ RBAC
❌ Tags alone

---

## SESSION 1.4E

# SUBSCRIPTIONS & MANAGEMENT GROUPS (GOVERNANCE VIEW)

---

## 1️⃣9️⃣ Why Management Groups Exist

Management Groups:

* Organize subscriptions
* Apply:

  * RBAC
  * Policy
  * Compliance
* Enable **enterprise governance**

They do:

* ❌ No billing
* ❌ No identity
* ❌ No resources

---

## 2️⃣0️⃣ Subscription Governance

Subscriptions:

* Are **billing boundaries**
* Are **RBAC scopes**
* Are **policy scopes**

Multiple subscriptions are used to:

* Separate environments
* Isolate costs
* Reduce blast radius

---

## 2️⃣1️⃣ Cost Governance (EXAM AWARENESS)

Managed using:

* Budgets
* Cost alerts
* Azure Advisor

(Deep dive later in monitoring section.)

---

## 2️⃣2️⃣ END-TO-END GOVERNANCE FLOW (EXAM THINKING)

```
Management Group
  └── Policy (what is allowed)
  └── RBAC (who can act)
  └── Subscription (billing)
      └── Resource Group (lifecycle)
          └── Resource (locked if needed)
```

---

## 2️⃣3️⃣ COMMON EXAM SCENARIOS (VERY HIGH YIELD)

### Scenario 1

> Prevent public IP creation in all subscriptions

✅ Policy (Deny) at Management Group

---

### Scenario 2

> Ensure all storage accounts are encrypted

✅ Policy (Audit / DeployIfNotExists)

---

### Scenario 3

> Prevent deletion of production DB

✅ Resource Lock (CanNotDelete)

---

### Scenario 4

> Track cost per application

✅ Tags + Cost Management

---

## 2️⃣4️⃣ WHY CANDIDATES FAIL SESSION 1.4

They:

* Use RBAC where Policy is needed
* Forget Policy effects
* Think Owner bypasses locks
* Assume tags enforce rules

Microsoft **designs questions around these mistakes**.

---

## 2️⃣5️⃣ FINAL LOCK-IN CHECK (CRITICAL)

Answer **YES / NO** instantly:

1. Can Azure Policy explicitly deny resource creation?
2. Can Owner bypass a resource lock?
3. Do tags enforce compliance by themselves?
4. Can policies be assigned at management group scope?
5. Does RBAC control what resource types can be created?

---
