# Day 01 – Linux User Setup with Non-Interactive Shell

## 📌 Task Description
Create a Linux user named `jim` with a **non-interactive shell** as required by a backup agent running on the server.

This task was performed on **App Server 3**.

---

## 🎯 Why This Task Is Important

In real-world environments:
- Backup agents
- Monitoring tools
- CI/CD runners
- Automation services

…all require system users **without interactive login access**.

Allowing SSH or shell access for service users is a **security risk**.

---

## 🛡️ Real-World Use Case

Organizations enforce:
- Least privilege access
- No human login for service accounts
- Reduced attack surface

A non-interactive shell ensures:
- The user can exist for processes
- Login attempts are blocked
- Compliance and security standards are met

---

## ⚙️ Implementation

### Create user with non-interactive shell
sudo useradd -s /sbin/nologin jim

###Verify user configuration

getent passwd jim 

###Expected output:

jim:x:1005:1005::/home/jim:/sbin/nologin

###Test login access

su - jim

###expected output

This account is currently not available.

✅ Outcome

User jim successfully created

Login access restricted

System secured against unauthorized access

🧠 Key Learning

Difference between interactive and non-interactive shells

Importance of service account security

Practical Linux user management in production systems

🏁 Conclusion

This task reinforces a core Linux and security concept that is frequently used in enterprise environments.
Documenting it ensures easy revision and long-term retention.

✔ Day 01 Completed
