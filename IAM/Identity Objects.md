
# AZ-104 MASTER TRAINING

## SESSION 1.1 — IDENTITY OBJECTS (IN-DEPTH)

> Azure recognizes **only identity objects** for authentication and authorization.
> Everything else is secondary.

---

# SESSION 1.1A

## Identity Objects — Complete Map (Big Picture First)

---

## 1️⃣ The ONLY Identity Objects Azure Understands

Microsoft Entra ID issues identities in **exactly four forms**:

| Identity Object       | Purpose                        |
| --------------------- | ------------------------------ |
| **User**              | Human identity                 |
| **Group**             | Collection of identities       |
| **Service Principal** | Application identity           |
| **Managed Identity**  | Azure-managed service identity |

If an exam option is **not one of these**, it is **not an identity**.

---

## 2️⃣ Identity Object vs Resource (Exam Elimination Rule)

| Item             | Identity? |
| ---------------- | --------- |
| Virtual Machine  | ❌ No      |
| App Service      | ❌ No      |
| Storage Account  | ❌ No      |
| User             | ✅ Yes     |
| Managed Identity | ✅ Yes     |

> Resources **consume identities**, they do not become identities.

---

## 3️⃣ How Identity Is Used in Azure (Flow)

Every access request follows this order:

1. **Authenticate** (Entra ID)
2. **Resolve identity object**
3. **Evaluate RBAC**
4. **Evaluate policy**
5. **Allow or deny**

If step 2 fails → everything fails.

---

# SESSION 1.1B

## USER OBJECT — COMPLETE DEEP DIVE

---

## 4️⃣ What a User Object REALLY Is

A **User** is:

* A **directory object**
* Representing a **human**
* Created inside a **tenant**
* With a permanent **Object ID**

Passwords can change.
Object ID **never changes**.

---

## 5️⃣ User Types (EXAM-CRITICAL)

### 1. Member User

* Internal employee
* Created directly in tenant
* Full directory permissions (relative)

### 2. Guest User (B2B)

* External user
* Invited into tenant
* Authenticates using **external identity provider**

> Azure **does NOT store guest passwords**

---

## 6️⃣ Guest User Lifecycle (Exam Favorite)

1. Admin sends invitation
2. Guest accepts invitation
3. Guest authenticates externally
4. Azure maps guest to **directory object**

Guest users:

* Can be assigned RBAC roles
* Are restricted by default

---

## 7️⃣ User Properties — EXAM LANDMINES

| Property           | Why It Matters        |
| ------------------ | --------------------- |
| UPN                | Login identity        |
| Object ID          | RBAC assignment       |
| Account Enabled    | Access allowed        |
| **Usage Location** | REQUIRED for licenses |

⚠️ **Very common exam failure**
User cannot use Microsoft 365 → **Usage Location not set**

---

## 8️⃣ Disable vs Delete User (VERY IMPORTANT)

| Action  | Result                               |
| ------- | ------------------------------------ |
| Disable | User blocked, object retained        |
| Delete  | Object removed (recoverable 30 days) |

Exam rule:

* Temporary access issue → **Disable**
* Permanent removal → **Delete**

---

## 9️⃣ Bulk User Operations (AZ-104 EXPECTS AWARENESS)

Admins can:

* Bulk create users (CSV)
* Bulk delete users
* Bulk invite guests

Portal:

```
Entra ID → Users → Bulk operations
```

---

# SESSION 1.1C

## GROUP OBJECT — COMPLETE DEEP DIVE

---

## 🔟 Why Groups Exist (Microsoft’s Intent)

Groups exist to:

* Reduce RBAC sprawl
* Simplify access management
* Enforce least privilege

Correct pattern:

```
User → Group → Role → Scope
```

---

## 1️⃣1️⃣ Group Types (DO NOT CONFUSE)

### Security Group

* Used for:

  * Azure RBAC
  * Conditional Access
* **Exam default for permissions**

### Microsoft 365 Group

* Used for:

  * Teams
  * Outlook
  * SharePoint

❌ Not designed for Azure RBAC questions

---

## 1️⃣2️⃣ Membership Types (VERY EXAM-HEAVY)

| Membership     | Control      |
| -------------- | ------------ |
| Assigned       | Manual       |
| Dynamic User   | Rule-based   |
| Dynamic Device | Device-based |

Dynamic groups:

* Auto add/remove
* Cannot manually edit members

---

## 1️⃣3️⃣ Dynamic Group Rules (Exam Awareness)

Example:

```
(user.department -eq "Finance")
```

Azure evaluates:

* On attribute change
* On schedule (not instant)

---

## 1️⃣4️⃣ When NOT to Use Dynamic Groups (Exam Trap)

Do NOT use when:

* Access must be temporary
* Attributes are inconsistent
* Immediate access is required

---

## 1️⃣5️⃣ Nested Groups (Limited but Exam Relevant)

* Security groups **can** contain other groups
* RBAC evaluation supports nesting
* Deep nesting discouraged

---

## 1️⃣6️⃣ RBAC + Groups (NON-NEGOTIABLE RULE)

Azure RBAC can be assigned to:

* Users
* **Security Groups**
* Service Principals
* Managed Identities

❌ Do NOT assign RBAC directly to many users unless required

---

## 1️⃣7️⃣ EXAM-STYLE SCENARIOS (CORE)

### Scenario 1

> Access must be automatically assigned based on department.

✅ Dynamic Security Group

---

### Scenario 2

> External consultant needs temporary access.

✅ Guest user + Assigned Security Group

---

### Scenario 3

> Users need Teams and mailbox access.

✅ Microsoft 365 Group + License

---

## 1️⃣8️⃣ WHY CANDIDATES FAIL SESSION 1.1

They:

* Treat users and groups as “simple”
* Ignore Object ID vs UPN
* Misuse Microsoft 365 groups for RBAC
* Forget usage location

Microsoft **expects admin-level clarity**, not theory.

---

## 1️⃣9️⃣ LOCK-IN CHECK (ANSWER WITHOUT THINKING)

Answer **YES / NO**:

1. Can a guest user be assigned an Azure RBAC role?
2. Can dynamic group membership be edited manually?
3. Is usage location required before license assignment?
4. Can RBAC be assigned to a Microsoft 365 group?

---
