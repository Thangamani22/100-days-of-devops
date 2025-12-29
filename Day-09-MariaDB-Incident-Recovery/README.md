# Day 09 – Production Incident Fix: MariaDB Service Recovery

## 📌 Scenario
The application in **Stratos Datacenter** failed to connect to its database.  
Investigation confirmed that the **MariaDB service on the database server was down**.

This task focused on **incident investigation, root-cause analysis, and service recovery**.

---

## 🎯 Objective
- Identify why MariaDB failed to start
- Fix the issue safely
- Restore database availability

---

## 🛠️ Environment
- **DB Server**: stdb01.stratos.xfusioncorp.com
- **Database**: MariaDB 10.5
- **OS**: Linux (systemd-based)

---

## 🔍 Investigation Summary
1. Checked service state using `systemctl status mariadb`
2. Analyzed MariaDB error logs at `/var/log/mariadb/mariadb.log`
3. Identified the root cause:

```text
Can't create/write to file '/run/mariadb/mariadb.pid' (Permission denied)
```

---

## 🚨 Root Cause
- MariaDB runs as the `mysql` user
- Runtime directory `/run/mariadb` was owned by `root`
- MariaDB could not create its PID file, causing startup failure

---

## ✅ Fix Applied
```bash
sudo chown mysql:mysql /run/mariadb
sudo chmod 755 /run/mariadb
```

Restarted the service:
```bash
sudo systemctl start mariadb
```

---

## ✔️ Result
- MariaDB service started successfully
- Database connectivity restored
- Application issue resolved

---

## 🧠 Key Takeaways
- `systemctl status` shows symptoms, not root causes
- Application error logs are essential for debugging
- Permission issues in `/run` are common after restarts
- Simple fixes often require deep investigation

---

## 💼 Skills Demonstrated
- Production incident troubleshooting
- Log-driven root cause analysis
- Linux permissions and ownership
- Database service recovery

---

**Status:** ✅ Resolved  
**Day 09 of #100DaysOfDevOps**
