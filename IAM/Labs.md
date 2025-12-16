# AZ-104 — SECTION 1 HANDS-ON LAB (DEEP DIVE)

## Identity, RBAC & Governance — END-TO-END

> **Goal:** By the end of this lab, every RBAC / Policy / Identity question should feel mechanical.

---

## LAB STRUCTURE (DO NOT SKIP ORDER)

1. Entra ID Users & Groups
2. Guest Users (B2B)
3. Service Principal
4. Managed Identity
5. RBAC at Multiple Scopes
6. Azure Policy (Deny + Audit)
7. Resource Locks
8. Tags + Governance Validation

---

## 🔹 LAB 1 — MICROSOFT ENTRA ID USERS (FOUNDATION)

### Task 1: Create Users

**Portal path**

```
Azure Portal → Microsoft Entra ID → Users → New user
```

Create **two users**:

| User        | Purpose        |
| ----------- | -------------- |
| az104-admin | Internal admin |
| az104-dev   | Normal user    |

Settings:

* User type: Member
* Auto-generate password
* Set **Usage location** (IMPORTANT)

🔑 **Exam Insight**
If usage location is missing → licensing fails.

---

### Task 2: Disable vs Delete (Critical Difference)

1. Disable `az104-dev`
2. Try to sign in → blocked
3. Re-enable
4. Delete user → note 30-day soft delete

🔑 **Exam Rule**

* Temporary access issue → Disable
* Permanent removal → Delete

---

## 🔹 LAB 2 — GROUPS (RBAC BEST PRACTICE)

### Task 3: Create Security Groups

Create **two groups**:

| Group        | Type     | Purpose    |
| ------------ | -------- | ---------- |
| az104-admins | Security | Admin RBAC |
| az104-devs   | Security | Dev RBAC   |

Membership:

* Assigned
* Add respective users

---

### Task 4: Dynamic Group (VERY EXAM-HEAVY)

Create a **dynamic security group**:

```
Group type: Security
Membership: Dynamic user
Rule: (user.jobTitle -contains "Admin")
```

🔑 **Exam Trap**

* Dynamic groups → no manual member edits
* Changes are **not instant**

---

## 🔹 LAB 3 — GUEST USER (B2B)

### Task 5: Invite Guest User

```
Entra ID → Users → New user → Invite external user
```

Invite a personal email.

Observe:

* User type = Guest
* No password stored in tenant

🔑 **Exam Rule**
Guest users authenticate using **their own identity provider**.

---

## 🔹 LAB 4 — SERVICE PRINCIPAL (APPLICATION IDENTITY)

### Task 6: Create App Registration

```
Entra ID → App registrations → New registration
```

* Name: az104-sp
* Single tenant

After creation:

* Go to **Certificates & secrets**
* Create **Client secret**

⚠️ Note expiry — exam mentions this often.

---

### Task 7: Service Principal = RBAC Identity

```
Subscription → Access Control (IAM) → Add role assignment
```

Assign:

* Role: Reader
* Member: az104-sp

🔑 **Exam Insight**
RBAC is applied to **Service Principal**, not App Registration UI object.

---

## 🔹 LAB 5 — MANAGED IDENTITIES (AZURE-MANAGED)

### Task 8: System-Assigned Managed Identity

Create a **Linux VM** (smallest size).

After creation:

```
VM → Identity → System assigned → On
```

Azure automatically:

* Creates identity in Entra ID
* Rotates credentials

---

### Task 9: User-Assigned Managed Identity

```
Create resource → Managed Identity → User assigned
```

Attach it to:

* Same VM

🔑 **Exam Decision Rule**

* One resource → System-assigned
* Multiple resources → User-assigned

---

## 🔹 LAB 6 — AZURE RBAC (MULTI-SCOPE)

### Task 10: RBAC at Resource Group Scope

Create RG:

```
rg-az104-test
```

Assign:

* az104-dev → Contributor → RG scope

Test:

* User can create VM in RG
* Cannot assign roles

---

### Task 11: Management Group RBAC (Conceptual)

If management groups exist:

* Assign Reader at MG
* Observe inheritance

🔑 **Exam Rule**
RBAC always flows **downward**

---

## 🔹 LAB 7 — AZURE POLICY (DENY + AUDIT)

### Task 12: Deny Policy

```
Policy → Definitions → Allowed locations
```

Assign at:

* Subscription

Effect:

* Deny non-allowed regions

Test:

* Try creating resource in blocked region → FAIL

---

### Task 13: Audit Policy

Assign:

* Audit VMs without monitoring

Check:

```
Policy → Compliance
```

🔑 **Exam Insight**
Audit ≠ deny

---

## 🔹 LAB 8 — RESOURCE LOCKS (OVERRIDE RBAC)

### Task 14: CanNotDelete Lock

```
Resource Group → Locks → Add
```

* Type: CanNotDelete

Test:

* Try deleting resource as Owner → FAIL

🔑 **Exam Rule**
Locks override **ALL RBAC roles**

---

## 🔹 LAB 9 — TAGS (GOVERNANCE LITE)

### Task 15: Apply Tags

Add tag:

```
CostCenter = Finance
```

Observe:

* RG tags do NOT inherit automatically

---

### Task 16: Enforce Tags with Policy

Assign policy:

* Require tag and value

Test:

* Create resource without tag → FAIL

---

## 🔹 FINAL VALIDATION — EXAM SIMULATION

Answer these **from your lab**, not memory:

1. Why could Owner not delete the resource?
2. Why did resource creation fail even with Contributor?
3. Why did dynamic group membership change automatically?
4. Why didn’t tags inherit?
5. Why didn’t Service Principal need portal access?

If you can answer using **lab evidence**, you are **exam-ready for Section 1**.

---

## WHAT YOU JUST ACHIEVED

You now **physically experienced**:

* Identity boundaries
* RBAC inheritance
* Policy enforcement
* Lock overrides
* Managed identity behavior

This is **far beyond theory**.

---
