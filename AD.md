---

# 📖 Active Directory (AD) Terminologies – Beginner to Advanced

This guide explains **Active Directory (AD) terminologies** in detail.
If you’re new, think of Active Directory as a **phonebook + security guard** for your organization’s IT environment:

* **Phonebook part** → It stores details about every user, computer, printer, and group (like a company directory).
* **Security guard part** → It checks who you are when you log in (authentication) and what you’re allowed to do (authorization).

---

## 🏷️ 1. Core Concepts

### 🔹 Active Directory (AD)

* A **directory service** built by Microsoft.
* Purpose: **Centralized management** of people, computers, and resources in a company’s IT environment.
* Without AD: Each computer would manage its own users. With AD: One place to manage **all accounts, policies, and access**.
* Example: Your company issues you a laptop → you log in with the same username/password on any PC in the office, because AD verifies your identity.

---

### 🔹 Domain

* The **basic building block** of AD.
* A domain is like a **security boundary** (a container for users, groups, and computers).
* Identified by a **DNS name**, e.g., `corp.example.com`.
* Inside one domain:

  * All objects are stored in **one database** (NTDS.dit).
  * Admins can create accounts, apply policies, and manage security.

👉 Analogy: Think of a **domain** as a branch office of a company.

---

### 🔹 Forest

* The **highest-level container** in AD.
* A forest is made up of one or more domains that share:

  * A **common schema** (rules for objects).
  * A **global catalog** (index of all objects).
  * **Trust relationships** (so domains can talk to each other).
* A **forest = the entire company** (all branch offices together).

---

### 🔹 Tree

* A group of **one or more domains** inside a forest.
* They share a **contiguous namespace**.
* Example:

  * `example.com` (root domain)
  * `hr.example.com` (child domain)
  * `sales.example.com` (child domain)

👉 Analogy: If the **forest is the company**, then a **tree is a department** with multiple sub-teams (domains).

---

## 🗂️ 2. Logical Components

### 🔹 Object

* The **basic unit stored in AD**.
* Every account, device, or resource = an **object**.
* Examples:

  * **User object** – represents an employee.
  * **Computer object** – represents a workstation/laptop.
  * **Group object** – represents a collection of users/computers.
  * **Printer object** – represents a network printer.

👉 Think of **objects as entries in the company directory**.

---

### 🔹 Schema

* The **set of rules** that defines:

  * What kind of objects can exist (users, computers, printers).
  * What attributes each object must/can have.

Example:

* A **User object** must have: `username`, `password`.
* A **User object** may have: `phone number`, `email`, `manager`.

👉 Schema = the **blueprint** for Active Directory.

---

### 🔹 Attributes

* **Properties of objects**.
* Example: A user might have:

  * `Name = John Doe`
  * `Email = john.doe@corp.com`
  * `Department = HR`
  * `SID = S-1-5-21-...`

👉 Attributes = **fields in the directory entry**.

---

### 🔹 Organizational Unit (OU)

* A **container** within a domain that helps organize objects.
* Purpose:

  * Apply **Group Policies** (e.g., password length, screen lock timeout).
  * Delegate **administration** (e.g., give HR staff rights to manage only HR users).

👉 Analogy: A **folder in Windows Explorer**, where you keep files organized.

---

### 🔹 Global Catalog (GC)

* A **special database** that contains a **partial copy of all objects in the forest**.
* Allows users to **search quickly** across multiple domains.

Example: If you’re in `hr.example.com` and search for a printer in `sales.example.com`, GC helps find it fast.

👉 GC = the **search index** of the company directory.

---

### 🔹 Trust Relationships

* Define **how domains share resources**.
* Types:

  * **One-way trust** → Domain A trusts B, but B doesn’t trust A.
  * **Two-way trust** → Both domains trust each other.
  * **Transitive trust** → Trust automatically flows between related domains.
  * **External trust** → Between AD and a non-AD environment.

👉 Analogy: **Access passes** between different office buildings.

---

## 🖥️ 3. Physical Components

### 🔹 Domain Controller (DC)

* A **server** that runs AD Domain Services (AD DS).
* Stores a **copy of the AD database**.
* Handles **logins, authentication, and directory queries**.

👉 A DC = the **receptionist/security desk** in the office.

---

### 🔹 Read-Only Domain Controller (RODC)

* A DC with a **read-only copy** of AD.
* Used in **remote/branch offices** where security is a concern.
* Even if stolen, attackers can’t change AD data.

👉 Think of it as a **backup receptionist** who can check employee lists but not edit them.

---

### 🔹 Site

* Represents the **physical network layout** (based on IP subnets).
* Purpose:

  * Optimize **replication traffic** between DCs.
  * Ensure users connect to the **nearest DC**.

👉 Site = **office location** (e.g., New York office vs London office).

---

### 🔹 Replication

* Process of **synchronizing changes** between DCs.
* Example: If an admin changes your password on one DC, replication makes sure **all DCs get updated**.

👉 Replication = **branch offices updating the master directory**.

---

### 🔹 FSMO Roles (Flexible Single Master Operations)

Some tasks can’t be handled by multiple DCs → special roles exist:

1. **Schema Master** – Controls schema changes.
2. **Domain Naming Master** – Manages adding/removing domains.
3. **RID Master** – Issues unique IDs for objects.
4. **PDC Emulator** – Handles password resets, time sync, legacy support.
5. **Infrastructure Master** – Updates group membership info.

👉 FSMO = **special admin responsibilities**.

---

## 🔐 4. Authentication & Authorization

### 🔹 Authentication

* Verifying **who you are** (username + password).

### 🔹 Authorization

* Verifying **what you can do** (permissions).

👉 Example: Logging into a PC = authentication.
👉 Accessing the finance folder = authorization.

---

### 🔹 Kerberos

* Default **authentication protocol** in AD.
* Uses **tickets** instead of passwords.
* More secure than NTLM.

👉 Think of it like a **movie ticket** – once verified, you show the ticket instead of your ID every time.

---

### 🔹 NTLM

* An older protocol (pre-Kerberos).
* Still used by **legacy applications**.

---

### 🔹 SID (Security Identifier)

* A **unique number** assigned to every object.
* Example: `S-1-5-21-2020202020-3434343434-5656565656-1001`
* Even if you delete a user and recreate them with the same name, they’ll get a **different SID**.

👉 SID = **employee ID badge**.

---

### 🔹 ACL (Access Control List)

* Defines **who has what permissions** on an object.
* Example:

  * Alice = Read access to HR folder.
  * Bob = Read + Write access.

👉 ACL = **rules list on the door of a room**.

---

### 🔹 GPO (Group Policy Object)

* A collection of **rules/settings** that control users/computers.
* Examples:

  * Force password to be 12+ characters.
  * Disable USB drives.
  * Set desktop wallpaper.

👉 GPO = **company policies enforced by IT**.

---

## 🌍 5. Other Important Terms

### 🔹 LDAP (Lightweight Directory Access Protocol)

* Protocol used by AD for **searching/modifying objects**.
* Example: Find all users in HR with `dsquery` or PowerShell.

---

### 🔹 UPN (User Principal Name)

* Login format: `username@domain.com`.

### 🔹 sAMAccountName

* Legacy login format: `DOMAIN\username`.

---

### 🔹 Groups

* **Security Group** – Used for access control (permissions).
* **Distribution Group** – Used for email distribution lists.

#### Group Scopes:

* **Domain Local** – Permissions only in one domain.
* **Global** – Can be used across trusted domains.
* **Universal** – Works across the entire forest.

---

### 🔹 SYSVOL

* Shared folder on DCs.
* Stores:

  * Group Policy templates.
  * Login scripts.

---

### 🔹 AD DS (Active Directory Domain Services)

* The Windows Server **role** that installs AD and makes a server a **Domain Controller**.

---

## 📌 Summary Diagram

```
Forest (Entire company)
 └── Tree (Departments)
      └── Domain (Branch office)
           ├── Organizational Units (OUs)
           │     ├── Users
           │     ├── Groups
           │     └── Computers
           └── Domain Controllers (DCs)
```

---
