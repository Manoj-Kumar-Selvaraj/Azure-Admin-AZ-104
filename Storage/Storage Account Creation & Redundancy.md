# AZ-104 — SECTION 2.1

## STORAGE ACCOUNT CREATION & REDUNDANCY (VERY IN-DEPTH)

This section is split into **four precision layers**:

* **2.1A — Storage account creation (what really happens)**
* **2.1B — Account types & performance (exam elimination rules)**
* **2.1C — Redundancy models (VERY HIGH EXAM WEIGHT)**
* **2.1D — Region, availability zones & change limitations (traps)**

---

## SECTION 2.1A

# Storage Account Creation — What AZURE ACTUALLY CREATES

---

## 1️⃣ What Happens When You Create a Storage Account

When you create a storage account, Azure creates:

1. A **globally unique DNS namespace**
2. A **replication topology**
3. A **security boundary**
4. A **billing meter**
5. Default endpoints for:

   * Blob
   * File
   * Queue
   * Table

This is **one atomic resource**.

---

## 2️⃣ Exam-Relevant Creation Parameters (DO NOT IGNORE)

When AZ-104 asks “Which settings should you configure?”, it almost always refers to **these fields**:

| Setting        | Why Exam Cares       |
| -------------- | -------------------- |
| Subscription   | Billing & isolation  |
| Resource Group | Lifecycle            |
| Region         | Latency, replication |
| Performance    | Standard vs Premium  |
| Redundancy     | Durability           |
| Account type   | Feature availability |

---

## 3️⃣ Region Selection (Exam Logic)

The **primary region** determines:

* Where data is written
* Where latency is lowest
* Which redundancy options are available

⚠️ **Exam trap**

> “Choose ZRS in a region that does not support Availability Zones”

→ Impossible configuration
→ Wrong answer

---

## SECTION 2.1B

# Storage Account Types & Performance (EXAM ELIMINATION RULES)

---

## 4️⃣ Storage Account Types — What Still Matters in AZ-104

| Type                   | Status  | Exam Behavior   |
| ---------------------- | ------- | --------------- |
| **General-purpose v2** | Current | ✅ Default       |
| General-purpose v1     | Legacy  | ❌ Avoid         |
| BlobStorage            | Legacy  | ❌ Avoid         |
| FileStorage            | Premium | ⚠️ Special case |

🔑 **If the question does NOT force a special case → GPv2 is correct**

---

## 5️⃣ Why GPv2 Is Almost Always Correct

GPv2 supports:

* All storage services
* All redundancy models
* All access tiers
* Lifecycle management
* Encryption & security features

AZ-104 expects you to **default to GPv2 unless constrained**.

---

## 6️⃣ Performance Tier (NOT the same as Redundancy)

| Tier     | Meaning                    |
| -------- | -------------------------- |
| Standard | HDD-backed, cost-optimized |
| Premium  | SSD-backed, low latency    |

### EXAM TRAP

> “Need high durability”

Durability ≠ Performance
Durability comes from **replication**, not premium tier.

---

## SECTION 2.1C

# Redundancy & Replication — EXAM AUTHOR FAVORITE

This section alone can decide **multiple questions**.

---

## 7️⃣ What Redundancy Protects Against (CLEARLY)

Redundancy protects against:

* Disk failure
* Node failure
* Rack failure
* Datacenter failure
* Region failure

Redundancy does **NOT** protect against:

* Accidental deletion
* Data corruption
* Ransomware

(Those are solved by **soft delete / versioning**, later.)

---

## 8️⃣ Redundancy Options (MEMORIZE THIS TABLE)

| Option      | Replication Scope          |
| ----------- | -------------------------- |
| **LRS**     | Single datacenter          |
| **ZRS**     | Availability Zones         |
| **GRS**     | Primary + secondary region |
| **GZRS**    | ZRS + geo-replication      |
| **RA-GRS**  | GRS + read access          |
| **RA-GZRS** | GZRS + read access         |

---

## 9️⃣ How AZ-104 EXPECTS YOU TO CHOOSE

### Decision Ladder (IMPORTANT)

1. Is **regional disaster recovery** required?

   * Yes → GRS / GZRS
   * No → LRS / ZRS

2. Is **AZ-level resilience** required?

   * Yes → ZRS / GZRS
   * No → LRS / GRS

3. Is **read access to secondary** required?

   * Yes → RA-* option

---

## 🔟 Secondary Region Behavior (COMMON TRAP)

* Secondary region:

  * ❌ Cannot write
  * ✅ Can read **only if RA-enabled**
* Failover:

  * Manual (GRS)
  * Microsoft-managed during disaster

---

## 1️⃣1️⃣ Cost Awareness (EXAM SUBTLE)

Cost increases in this order:

```
LRS → ZRS → GRS → GZRS → RA-GZRS
```

AZ-104 expects:

> **Cheapest option that meets requirements**

---

## SECTION 2.1D

# Change Limitations & Availability Zones (TRAPS)

---

## 1️⃣2️⃣ Can You Change Replication Later?

Some changes are allowed:

* LRS → GRS
* LRS → ZRS (region-dependent)

Some are NOT always allowed:

* ZRS → LRS
* GZRS → GRS

⚠️ **Exam wording**

> “You must choose a replication option during creation”

→ Pay attention to **irreversibility**

---

## 1️⃣3️⃣ Availability Zones Dependency

* ZRS and GZRS:

  * Require regions that support AZs
* Not all regions support AZs

If AZ is mentioned:

* LRS = ❌
* GRS = ❌
* ZRS / GZRS = ✅

---

## 1️⃣4️⃣ Real AZ-104 Exam Scenarios (VERY HIGH YIELD)

### Scenario 1

> Minimize cost, no DR requirement.

✅ LRS

---

### Scenario 2

> Survive datacenter failure within region.

✅ ZRS

---

### Scenario 3

> Survive region outage, no read from secondary.

✅ GRS

---

### Scenario 4

> Read access during regional outage.

✅ RA-GRS

---

### Scenario 5

> AZ resilience + regional DR.

✅ GZRS

---

## 1️⃣5️⃣ Common Wrong Answers (WHY THEY FAIL)

❌ Choosing Premium for durability
❌ Choosing RA-GRS when read access is not required
❌ Choosing ZRS in non-AZ region
❌ Over-engineering (exam penalizes this)

---

## 1️⃣6️⃣ EXAM MINDSET SUMMARY (MEMORIZE)

* Account type → GPv2 unless forced
* Performance ≠ durability
* Redundancy = durability
* Cheapest that meets requirements
* AZ mention = ZRS/GZRS
* Read from secondary = RA option

---

## 1️⃣7️⃣ LOCK-IN CHECK (ANSWER WITHOUT THINKING)

Answer **YES / NO**:

1. Does ZRS protect against regional outage?
2. Can you write to the secondary region in GRS?
3. Is GPv2 the recommended default account type?
4. Does Premium automatically mean higher durability?
5. Is RA-GRS required if no read access is needed?

If any hesitation → we revisit.

---
