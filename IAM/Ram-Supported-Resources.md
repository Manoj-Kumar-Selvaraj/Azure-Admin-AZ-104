# Azure Resource Move – AZ-104 Quick Reference

This README provides a **concise, exam-oriented guide** to understanding which Azure resources **can be moved** and **cannot be moved** across **resource groups**, **subscriptions**, and **regions**, aligned with **AZ-104 (Microsoft Azure Administrator)** expectations.

---

## Scope & Purpose

* Designed for **AZ-104 preparation** and **day-to-day admin decisions**
* Focuses on **patterns**, not the full Microsoft matrix
* Helps answer **exam questions quickly and correctly**

---

## Golden Rules (Must Memorize)

1. **Tenant boundary is absolute**
   Resources **cannot be moved across Microsoft Entra ID tenants**.

2. **Child resources move with parent only**

   * Child resources **cannot be moved independently**
   * If the parent cannot move, the child cannot move

3. **Region move ≠ RG / Subscription move**

   * RG / Subscription moves are common
   * Region moves are rare and usually require **Azure Resource Mover**, **templates**, or **recreation**

---

## Category 1: Resources That Are Commonly Movable

These are the **safest YES answers** in AZ-104.

### Compute & Core Infrastructure

* Virtual Machines
* VM Scale Sets
* Managed Disks (Full only)
* Availability Sets
* Proximity Placement Groups
* VM Images (not Shared Image Gallery)
* Network Interfaces (NICs)
* Network Security Groups (NSGs)
* Route Tables
* Virtual Networks (VNets)

**Memory aid:** *If it runs workloads, it is usually movable.*

---

### Storage & Data

* Storage Accounts
* Azure SQL Servers and Databases (with constraints)
* Azure SQL Elastic Pools
* Cosmos DB (RU-based only)
* Azure File Sync
* Backup Vaults (RG / subscription only)

---

### App & Integration

* App Service Plans
* Web Apps
* Function Apps
* API Management (except Consumption SKU)
* Logic Apps (Standard)
* Service Bus Namespaces
* Event Hubs Namespaces
* SignalR Service

---

### Monitoring & Operations

* Log Analytics Workspaces
* Application Insights
* Action Groups
* Alert Rules
* Dashboards
* Workbooks

---

## Category 2: Movable but NOT Across Regions

These resources can move between **resource groups** or **subscriptions**, but **not regions** unless recreated.

* App Service resources
* Azure SQL Databases
* Key Vault
* Redis Cache
* Cosmos DB
* Event Grid
* Azure Container Registry
* AKS (cannot be directly moved)

**Memory aid:** *Platform services do not like region hopping.*

---

## Category 3: Region Move Requires Special Tools

Region moves are supported **only via Azure Resource Mover or templates**.

* Virtual Machines
* Managed Disks
* Network Security Groups
* Network Interfaces
* Load Balancers
* Availability Sets
* Azure SQL (Resource Mover)
* Event Hubs (ARM template)
* Service Bus (ARM template)

**Key idea:** *Region move = migrate, not move.*

---

## Category 4: Never Movable (Control Plane & Global Services)

If you see these in a question, the answer is **NO**.

### Identity & Governance

* Azure AD / Microsoft Entra ID
* Tenants
* Managed Identities
* Role Assignments
* Role Definitions
* Policies
* Locks
* Blueprints

### Billing & Management

* Subscriptions
* Billing Accounts
* Cost Management
* Reservations
* Marketplace Resources

### Security & Compliance

* Microsoft Defender for Cloud
* Security Center
* Policy Insights

**Memory aid:** *Identity, billing, and governance never move.*

---

## Category 5: Networking – Mixed Behavior (Exam Favorite)

| Resource               | RG / Subscription Move | Region Move          |
| ---------------------- | ---------------------- | -------------------- |
| Virtual Network        | Yes                    | Yes (Resource Mover) |
| Subnet                 | With VNet              | With VNet            |
| Network Security Group | Yes                    | Yes                  |
| Network Interface      | Yes                    | Yes                  |
| Load Balancer          | Yes                    | Yes                  |
| Application Gateway    | No                     | No                   |
| Azure Firewall         | No                     | No                   |
| ExpressRoute           | No                     | No                   |
| VPN Gateway            | No                     | No                   |
| Bastion                | RG only                | No                   |

**Memory aid:** *Attached network objects move; gateways do not.*

---

## Category 6: App Service – Special Exam Rules

* Cannot move across tenants
* Cannot move API Management (Consumption SKU)
* Cannot move Function Apps between OS types
* Cannot move Key Vault used for disk encryption

Allowed (within same tenant):

* App Service Plans
* Web Apps
* Function Apps

---

## Ultra-Short Exam Memory Card

```
CAN MOVE:
VMs, Disks, VNets, NSGs, NICs, Storage, SQL, App Service

CANNOT MOVE:
AAD, RBAC, Policy, Locks, Billing, Subscriptions

REGION MOVE:
Use Azure Resource Mover or Recreate

NEVER:
Across tenants
```

---

## How AZ-104 Questions Are Typically Asked

* Can this resource be moved across subscriptions?
* Why did a move operation fail?
* Which dependency blocks the move?
* What must be removed before moving? (Locks, encryption, gateways)

They **will not** ask you to memorize provider-level matrices. They **will** test your understanding of these patterns.

---

# Common Azure Resources That **DO NOT SUPPORT MOVE**

## 1. Identity, Governance & Control Plane (🚫 NEVER MOVE)

If you see any of these → **answer is NO immediately**

* Azure AD / Microsoft Entra ID
* Tenants
* Managed Identities
* Role Assignments (RBAC)
* Role Definitions
* Policies
* Policy Assignments
* Locks
* Blueprints
* Management Groups
* Subscriptions (cannot be moved, only reassociated)

**Memory rule:**

> *Identity & governance objects never move.*

---

## 2. Billing & Cost Management (🚫 NEVER MOVE)

* Billing accounts
* Invoices
* Cost Management budgets
* Reservations
* Marketplace purchases
* CSP-linked resources (often blocked)

**Exam hint:**
Billing objects are **global**, not ARM resources.

---

## 3. Networking Gateways & Edge Services (🚫 VERY COMMON TRAP)

These are **frequently tested**.

* Application Gateway
* Azure Firewall
* VPN Gateway
* ExpressRoute Circuit
* ExpressRoute Gateway
* NAT Gateway
* Bastion Host
* Front Door (Classic / Standard / Premium)
* Virtual WAN & VPN Sites

**Memory rule:**

> *Gateways don’t move.*

---

## 4. Platform & Orchestrated Services (🚫 CANNOT MOVE)

* AKS (Azure Kubernetes Service)
* Azure Container Instances
* Azure Databricks
* Azure Synapse Analytics
* Azure Red Hat OpenShift
* HDInsight (networking blocks most moves)
* Service Fabric Managed Clusters

**Exam pattern:**
Managed / orchestrated services usually require **re-creation**, not move.

---

## 5. Security & Monitoring (Mostly 🚫)

* Microsoft Defender for Cloud
* Security Center
* Security policies
* Diagnostic settings
* Activity logs
* Azure Monitor metrics
* Policy Insights

**Exception (know this):**
✔ Log Analytics Workspace → **can move**
✔ Application Insights → **can move (with data caveats)**

---

## 6. Key Vault (⚠️ CONDITIONAL – Exam Favorite)

* ❌ Key Vault used for **disk encryption** → cannot move
* ❌ Managed HSM → cannot move
* ✔ Normal Key Vault → RG / subscription move allowed

**Exam trick:**
If Key Vault encrypts disks → **move fails**

---

## 7. App Service Special “NO” Cases

* API Management **Consumption SKU**
* Function Apps between OS types
* App Services across tenants
* Deleted App Services
* App Service Environment (ASE)

---

## 8. Data & Messaging – Common “NO”

* Azure Redis Enterprise
* Cosmos DB vCore (Mongo vCore, Cassandra)
* IoT Hub Device Provisioning Service (DPS) (limited)
* Azure Cognitive Search clusters (region move = recreate)

---

## Ultra-Short Exam Memory Card

```
NEVER MOVE:
AAD, RBAC, Policy, Locks, Billing, Subscriptions

NETWORK NO:
Gateway, Firewall, VPN, ExpressRoute, Bastion

PLATFORM NO:
AKS, Databricks, Synapse, ARO

KEY VAULT TRAP:
Disk encryption → NO MOVE
```

---

## How AZ-104 Questions Usually Look

**“You attempt to move a resource and the operation fails. Why?”**

Correct answers often include:

* Resource has a **lock**
* Resource is a **gateway**
* Resource is **identity / governance**
* Resource is **used for disk encryption**
* Resource is **platform-managed**

---

For deep migrations, always validate against official Azure documentation.
