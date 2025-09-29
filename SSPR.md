---

# 🚀 Setup Guide: Self-Service Password Reset (SSPR) in Azure Entra ID

## 📌 Overview

Self-Service Password Reset (SSPR) allows users in your organization to reset their Azure AD/Entra ID passwords securely without contacting IT support.
This reduces **help desk costs** and improves **end-user productivity**.

---

## 🛠️ Prerequisites

* An **Azure subscription** with **Entra ID (Azure AD)**.
* At least **Entra ID Free** license (basic SSPR features).

  * For **writeback to on-prem AD**, you need **Azure AD Premium P1 or P2**.
* You must be a **Global Administrator** or **Password Administrator** in Azure AD to configure it.

---

## ⚙️ Step 1: Enable SSPR

1. Go to **Azure Portal** → **Azure Active Directory** → **Password Reset**.
2. Under **Properties**, set **Self Service Password Reset Enabled** to one of:

   * **None** → Disabled
   * **Selected** → Only specific groups can use SSPR (recommended for pilots).
   * **All** → All users in directory can use SSPR.

✅ For testing, choose **Selected** and assign a test user group.

---

## ⚙️ Step 2: Configure Authentication Methods

1. In **Password Reset → Authentication Methods**, configure how users will prove their identity.

   * Recommended to require **at least 2 methods**.
   * Options include:

     * Mobile phone (SMS/Call)
     * Office phone
     * Email
     * Security questions (not recommended for security-sensitive orgs)
     * Microsoft Authenticator app
2. Example setup:

   * Require **2 methods**.
   * Allow: **Mobile phone** + **Authenticator app**.

---

## ⚙️ Step 3: Configure Registration Options

1. In **Password Reset → Registration**, choose:

   * Require users to register when they sign in → **Yes**.
   * Set re-confirmation period (default = 180 days).

This ensures users keep their authentication info updated.

---

## ⚙️ Step 4: Notifications

1. In **Password Reset → Notifications**:

   * **Notify users on password resets** → **Yes**.
   * **Notify all admins when other admins reset their password** → **Yes** (security best practice).

---

## ⚙️ Step 5: (Optional) Writeback to On-Prem AD

If you use **Hybrid Identity** (Azure AD + on-prem AD), enable **Password Writeback**:

1. Install **Azure AD Connect** on your on-premises AD server.
2. During setup, enable **Password Writeback**.
3. This ensures that when users reset their passwords in Azure AD, it also updates in on-premises AD.

---

## ⚙️ Step 6: Test SSPR

1. Log in with a test user → go to [https://aka.ms/sspr](https://aka.ms/sspr).
2. Enter the username → verify identity using configured methods.
3. Reset password successfully.
4. Try logging in with the new password.

---

## 🔒 Best Practices

* Start with a **pilot group** (IT staff or test users) before rolling out.
* Require **two authentication methods** for stronger security.
* Integrate with **MFA registration** so users only register once for both MFA + SSPR.
* Regularly review logs:

  * Azure Portal → **Azure Active Directory → Audit Logs**
  * Look for password reset events.

---

## ✅ Benefits

* Reduces **help desk calls by up to 50%**.
* Cuts **20%+ of IT support costs** (from password reset requests).
* Improves **user productivity** (faster password recovery).

---
