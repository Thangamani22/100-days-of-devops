# Linux Temporary User with Expiry Date

## 📌 Task Overview
A developer requires access to a server for a **limited duration**.  
To manage access securely, a temporary Linux user must be created with a **defined account expiry date**.

This ensures access is **automatically revoked** after the project duration ends.

---

## 🎯 Goal
- Create a temporary user account
- Set a fixed expiry date
- Avoid manual cleanup
- Follow least-privilege and access lifecycle best practices

---

## 🧠 Why This Is Important

In real-world environments, access is often granted to:
- Contractors
- Temporary developers
- Auditors
- Short-term support engineers

If access is not time-bound:
- Users may retain access longer than needed
- Security risks increase
- Compliance violations may occur

Account expiry enforces **automatic access revocation**, reducing human error.

---

## 🌍 Real-World Scenario

A developer is assigned to a project for a few days or weeks.  
Instead of remembering to delete the account later, administrators define an **expiry date upfront**.

Once the expiry date is reached:
- SSH access is denied
- `su` access is denied
- The account becomes inactive automatically

---

## ⚙️ Implementation (Linux)

### Create a user with an expiry date
```bash
sudo useradd -e 2023-12-07 jim
```

### Verify account expiry details
```bash
sudo chage -l jim
```

### Expected output includes:

Account expires : Dec 07, 2023

### 🔍 How It Works Internally

Linux stores account lifecycle information in:
```bash
/etc/shadow
```
1. Expiry dates are stored as days since Jan 1, 1970
1. chage converts this into human-readable format
1. Authentication mechanisms check expiry during login attempts
``

### 🪟 Windows Equivalent (Cross-Platform Perspective)

Windows does not use shells like Linux.
Instead, temporary access is managed using account policies.

Typical approach:

Create a local or domain user

Set account expiration (Active Directory or local policy)

Deny interactive logon (local / RDP)

Allow only required service or task permissions

Key Comparison
Linux	Windows
Account expiry (-e, chage)	Account expiration policies
/etc/shadow	Local Security Policy / AD
Shell-based access control	Policy-based access control
✅ Outcome

Temporary access granted securely

Automatic access revocation ensured

Reduced operational and security risk

🧠 Key Learnings

Importance of access lifecycle management

Difference between temporary access and permanent users

How Linux enforces expiry at authentication level

Cross-platform IAM principles

🏁 Conclusion

Time-bound access is a core security practice, not an optional feature.
This task reinforces how small configurations can have a big impact on system security and compliance.

✔ Task Completed
