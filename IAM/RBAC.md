# AZ-104 MASTER TRAINING

## SESSION 1.3 — AZURE RBAC (ROLE-BASED ACCESS CONTROL)

**Weight in exam:** Very High
**Hidden dependency:** Sessions 1.0 → 1.2
If those are weak, RBAC feels random. If they are strong, RBAC becomes mechanical.

---

# SESSION 1.3A

## WHAT AZURE RBAC REALLY IS (CONCEPTUAL TRUTH)

---

## 1️⃣ What Azure RBAC Solves

Azure RBAC answers **exactly one question**:

> **“Is this identity allowed to perform this action at this scope?”**

RBAC is:

* Authorization system
* Enforced at **Azure Resource Manager (ARM)** layer
* Evaluated **after authentication**

---

## 2️⃣ Authentication vs RBAC (EXAM REPEAT, DIFFERENT ANGLE)

Flow of every Azure request:

```
Identity → Entra ID (AuthN)
        → ARM (RBAC check)
        → Resource Provider
```

If RBAC fails:

* Portal shows resource
* Action fails (403 / AuthorizationFailed)

---

## 3️⃣ What RBAC Does NOT Do (EXAM ELIMINATION)

RBAC does **NOT**:

* Control OS-level access (VM login)
* Control SQL database users
* Control Storage file permissions (data plane)
* Replace network security

If question mentions:

* RDP / SSH
* NTFS permissions
* SQL logins

👉 **Not RBAC**

---

## 4️⃣ RBAC Building Blocks (MEMORIZE)

Azure RBAC has **three components**:

```
Security Principal + Role Definition + Scope
```

If any one is missing → access fails.

---

# SESSION 1.3B

## RBAC COMPONENTS — DEEP DIVE

---

## 5️⃣ Security Principal (WHO)

Security Principal can be:

* User
* Security Group
* Service Principal
* Managed Identity

❌ Resource
❌ Subscription

---

## 6️⃣ Role Definition (WHAT)

A **role definition** is a set of permissions.

Permissions are:

* `Actions` (control plane)
* `DataActions` (data plane, limited)

Example:

```
Microsoft.Compute/virtualMachines/start/action
```

---

### Built-in vs Custom Roles

| Type     | Exam Expectation |
| -------- | ---------------- |
| Built-in | Preferred        |
| Custom   | Only if required |

AZ-104 focuses **mostly on built-in roles**, not custom role authoring.

---

## 7️⃣ MOST IMPORTANT BUILT-IN ROLES (NON-NEGOTIABLE)

### Owner

* Full access
* Can assign roles

### Contributor

* Full access
* ❌ Cannot assign roles

### Reader

* Read-only

### User Access Administrator

* Can assign RBAC roles
* ❌ No resource modification

⚠️ **Exam Trap**

> “User must manage access but not resources”

✅ **User Access Administrator**

---

## 8️⃣ Scope (WHERE)

RBAC is always applied at a **scope**.

Valid scopes:

```
Management Group
Subscription
Resource Group
Resource
```

---

## 9️⃣ Scope Inheritance (EXAM GUARANTEED)

RBAC **always inherits downward**.

```
MG → Subscription → RG → Resource
```

There is:

* ❌ No upward inheritance
* ❌ No sideways inheritance

---

## 🔟 Scope Decision Logic (Exam Thinking)

| Requirement                   | Correct Scope    |
| ----------------------------- | ---------------- |
| Across multiple subscriptions | Management Group |
| Entire subscription           | Subscription     |
| App-specific resources        | Resource Group   |
| Single resource               | Resource         |

---

# SESSION 1.3C

## ROLE ASSIGNMENTS & EFFECTIVE ACCESS

---

## 1️⃣1️⃣ Role Assignment (WHAT IT IS)

A **role assignment** is the binding of:

```
Security Principal + Role + Scope
```

Without assignment:

* Identity exists
* Access does NOT

---

## 1️⃣2️⃣ Multiple Role Assignments (VERY IMPORTANT)

An identity can have:

* Multiple roles
* At multiple scopes

Azure calculates **effective permissions** as:

> **Union of all allowed permissions**

⚠️ There is **no explicit deny** in RBAC.

---

## 1️⃣3️⃣ RBAC DENY — EXAM TRICK

RBAC itself:

* Has **NO deny**
* Only allows

Denials come from:

* Azure Policy
* Resource Locks

If question mentions:

> “Explicit deny”

👉 Not RBAC.

---

## 1️⃣4️⃣ Effective Access Evaluation (Exam Scenario)

Azure checks:

1. Direct role assignments
2. Group-based assignments
3. Inherited assignments

If ANY role allows action → allowed.

---

## 1️⃣5️⃣ RBAC & Groups (WHY MICROSOFT PREFERS GROUPS)

Best practice:

```
User → Security Group → Role → Scope
```

Why:

* Scalability
* Auditing
* Least privilege

AZ-104 expects you to **prefer group-based RBAC**.

---

# SESSION 1.3D

## EXAM TRAPS, SCENARIOS & MISCONCEPTIONS

---

## 1️⃣6️⃣ RBAC vs POLICY (VERY COMMON CONFUSION)

| Feature    | RBAC           | Policy          |
| ---------- | -------------- | --------------- |
| Purpose    | Who can act    | What is allowed |
| Allow/Deny | Allow only     | Enforce / Deny  |
| Scope      | Identity-based | Resource-based  |

---

## 1️⃣7️⃣ RBAC vs RESOURCE LOCKS

| Lock         | Purpose          |
| ------------ | ---------------- |
| ReadOnly     | Prevent changes  |
| CanNotDelete | Prevent deletion |

Locks apply **regardless of RBAC**.

---

## 1️⃣8️⃣ EXAM-STYLE SCENARIOS (HIGH YIELD)

### Scenario 1

> User can create VMs but cannot assign roles.

✅ Contributor (expected behavior)

---

### Scenario 2

> User must manage access but not resources.

✅ User Access Administrator

---

### Scenario 3

> Apply same access across all subscriptions.

✅ Assign role at Management Group

---

### Scenario 4

> User sees resource but cannot delete it.

✅ Resource Lock (CanNotDelete)

---

## 1️⃣9️⃣ WHY CANDIDATES FAIL SESSION 1.3

They:

* Mix RBAC with Policy
* Forget inheritance
* Misuse Owner vs Contributor
* Assume deny exists in RBAC

Microsoft **intentionally designs questions around these mistakes**.

---

## 2️⃣0️⃣ LOCK-IN CHECK (DO NOT SKIP)

Answer **YES / NO** instantly:

1. Does RBAC support explicit deny?
2. Does Contributor allow role assignment?
3. Does RBAC inherit upward?
4. Can a user gain access via group membership?
5. Can a lock override Owner permissions?

---
