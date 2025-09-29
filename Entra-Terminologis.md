---

# ☁️ Azure Entra ID (Azure AD) Terminologies – Beginner to Advanced

Azure Entra ID (formerly **Azure Active Directory**) is Microsoft’s **cloud-based identity and access management (IAM)** service.
Unlike traditional AD, which runs **on-premises**, Entra ID is **cloud-native**, globally distributed, and integrates with **Microsoft 365, Azure, SaaS apps, and custom applications**.

This guide explains key **Entra ID terminologies** and **compares them to on-prem AD** for clarity.

---

## 🏷️ 1. Core Concepts

### 🔹 Tenant

* An **instance of Azure Entra ID** dedicated to an organization.
* Created automatically when you sign up for Azure or Microsoft 365.
* Identified by a **globally unique tenant ID (GUID)**.

👉 Analogy: If AD **Domain = branch office**, then Entra **Tenant = your entire company in the cloud**.

---

### 🔹 Directory

* The **container** that holds all users, groups, devices, and applications in your tenant.
* Directory = Tenant (used interchangeably).

👉 Equivalent to **AD Forest** (but only one per tenant).

---

### 🔹 Domain Name

* Each tenant has a **primary domain name** like `contoso.onmicrosoft.com`.
* You can add custom domains like `contoso.com`.

👉 Equivalent to **AD Domain**.

---

## 🗂️ 2. Identity Types

### 🔹 User

* Represents a person or service account.
* Two main types:

  1. **Cloud-only users** → Managed only in Entra ID.
  2. **Synchronized users** → Synced from on-prem AD using **Entra Connect**.

👉 Equivalent to **AD User objects**.

---

### 🔹 Guest User (B2B Collaboration)

* External users invited via their email (e.g., Gmail, another org’s Entra ID).
* Shown as `user@otherdomain.com`.
* Managed using **External Identities**.

👉 In AD, external users require trust relationships; in Entra, guests are built-in.

---

### 🔹 Service Principal

* Identity for an **application or service** to access Azure resources.
* Created when you register an app in Entra ID.

👉 Equivalent to a **service account** in AD, but cloud-native.

---

### 🔹 Managed Identity

* A special type of service principal automatically managed by Azure.
* Used by Azure resources (VMs, Functions, Logic Apps, etc.) to authenticate **without passwords or secrets**.

👉 Like an AD machine account, but automated for cloud.

---

### 🔹 Groups

* Collections of users, devices, or service principals.
* Two types:

  1. **Security Groups** → For access control.
  2. **Microsoft 365 Groups (M365 Groups)** → For collaboration (Teams, Outlook, SharePoint).

👉 Equivalent to AD **Security Groups** and **Distribution Groups**, but with added cloud collaboration features.

---

## 🔐 3. Authentication & Authorization

### 🔹 Authentication Methods

* Entra ID supports multiple:

  * Password
  * **Multi-Factor Authentication (MFA)** (phone, SMS, authenticator app, FIDO2 keys)
  * Passwordless (Windows Hello, Authenticator app, FIDO2)

👉 AD = mainly Kerberos/NTLM, Entra = modern MFA/passwordless.

---

### 🔹 Conditional Access

* **Policies that enforce access controls** based on conditions like:

  * User role
  * Device compliance
  * Location
  * Application
* Example: "Finance users must use MFA if logging in outside office hours."

👉 Equivalent to a **modern cloud version of AD Group Policies + firewall rules**.

---

### 🔹 Role-Based Access Control (RBAC)

* Permissions model in Azure.
* Assign **roles** (like Reader, Contributor, Owner) to users, groups, or service principals.

👉 Similar to **AD ACLs**, but broader and cloud-scoped.

---

### 🔹 Privileged Identity Management (PIM)

* Service to manage **just-in-time (JIT) access** for privileged accounts.
* Example: Grant admin rights only when needed, not permanently.

👉 AD = static domain admins; Entra = time-bound elevated access.

---

## 🌍 4. External Collaboration & Federation

### 🔹 External Identities

* Feature to allow **partners, vendors, or customers** to authenticate into your apps.
* Supports **Azure B2B** (business-to-business) and **B2C** (business-to-customer).

---

### 🔹 Federation

* Using another **identity provider (IdP)** for authentication.
* Example: Allow users from Google Workspace to log in to your Azure apps.

👉 Equivalent to **AD trusts**, but using modern protocols like SAML, OAuth, OpenID Connect.

---

### 🔹 B2B (Business-to-Business)

* Invite external users (partners, vendors) into your tenant.
* They log in with their **own credentials** (no new account needed).

---

### 🔹 B2C (Business-to-Consumer)

* For applications that serve **customers** (not employees).
* Supports multiple identity providers: Google, Facebook, Microsoft accounts.

👉 Example: A retail website using Azure AD B2C to let customers log in with Gmail.

---

## 🖥️ 5. Device & Application Management

### 🔹 Device Registration

* Devices (Windows, macOS, iOS, Android) can be:

  * **Registered** → Personal devices.
  * **Joined** → Organization-owned devices.
  * **Hybrid-Joined** → Joined to both on-prem AD and Entra.

👉 Equivalent to **AD Computer objects**, but cloud-aware.

---

### 🔹 Enterprise Applications

* Apps integrated with Entra ID for **Single Sign-On (SSO)** and **access control**.
* Examples: Salesforce, ServiceNow, custom apps.

---

### 🔹 App Registration

* Process of creating an **identity for an application** inside Entra ID.
* Generates:

  * **Application (client) ID**
  * **Directory (tenant) ID**
  * Optional secrets/certificates

👉 Equivalent to **service account creation in AD**, but with OAuth2/OpenID Connect support.

---

## ⚙️ 6. Security & Monitoring

### 🔹 Identity Protection

* Detects and blocks risky sign-ins (e.g., login from unusual location).
* Can enforce MFA or block access automatically.

---

### 🔹 Access Reviews

* Regular reviews of group memberships and app assignments to ensure **least privilege**.

---

### 🔹 Audit Logs

* Record of all activities:

  * Who logged in
  * Which app was accessed
  * Policy decisions applied

👉 Similar to **AD Event Logs**, but centralized and cloud-scale.

---

## 📌 Comparison: AD vs Entra ID

| Feature / Term    | Active Directory (On-prem) | Azure Entra ID (Cloud)                  |
| ----------------- | -------------------------- | --------------------------------------- |
| Forest / Tenant   | Multiple forests possible  | One tenant per org                      |
| Domain            | Logical boundary           | Domain names (custom + onmicrosoft.com) |
| Users             | User objects in AD         | Cloud-only + synced users               |
| Groups            | Security / Distribution    | Security + M365 Groups                  |
| Trusts            | Transitive / External      | Federation / B2B / B2C                  |
| Authentication    | Kerberos / NTLM            | Password, MFA, OAuth, SAML, OIDC        |
| Policies          | Group Policy (GPO)         | Conditional Access                      |
| Service Accounts  | Manual                     | Service Principals / Managed Identities |
| Devices           | Computer accounts          | Registered / Joined / Hybrid-joined     |
| Privileged Access | Domain Admins              | PIM (Just-in-time access)               |

---

## 📚 References

* [Microsoft Learn – Azure Entra Overview](https://learn.microsoft.com/en-us/entra/fundamentals/whatis)
* [Azure AD vs Active Directory](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-compare-azure-ad-to-ad)
* [Identity Protection in Entra ID](https://learn.microsoft.com/en-us/entra/id-protection/overview-identity-protection)

---

Would you like me to **expand this README** with **real-world scenarios** (e.g., “how does login flow work in Entra with MFA vs without MFA”) so you see **practical use cases** of these terms?
