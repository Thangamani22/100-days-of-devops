# Day 09 – MariaDB Incident Troubleshooting Notes

> This file is a **learning-focused note** meant for revision and deep understanding.  
> It documents the *entire troubleshooting journey* taken to fix the MariaDB outage,
> including wrong paths, corrections, and the final root cause.

This complements the recruiter-facing `README.md`.

---

## 🧠 Problem Context

- Application could not connect to the database
- Production support identified MariaDB service as down
- Goal was to **restore service availability**, not redesign the database

---

## 🔍 Step 1: Start with systemd (Symptom Identification)

First command used:

```bash
sudo systemctl status mariadb
```

What this told us:
- MariaDB service **failed to start**
- systemd reported `exit-code`
- No clear reason for failure

### Important learning
- `systemctl status` only shows **symptoms**
- It does NOT explain *why* the application failed internally

At this point, we **should not guess** or blindly restart.

---

## 🔁 Why We Moved Away from systemd Logs

Repeated checks of:
```bash
systemctl status mariadb
journalctl -u mariadb
```

Result:
- systemd confirmed failure
- But logs were noisy (container warnings, cgroup messages)
- No actionable root cause

### Key decision
👉 When a service binary exits with `status=1`,  
**the real reason lives in the application’s own log**, not systemd.

This is when we intentionally switched to MariaDB logs.

---

## 🔍 Step 2: Analyze MariaDB Error Log (Root Cause Discovery)

Checked MariaDB log:

```bash
sudo tail -n 50 /var/log/mariadb/mariadb.log
```

This immediately revealed the real issue:

```text
[ERROR] mariadbd: Can't create/write to file '/run/mariadb/mariadb.pid'
(Errcode: 13 "Permission denied")
[ERROR] Can't start server: can't create PID file: Permission denied
```

---

## 🚨 Root Cause Identified

- MariaDB runs as the `mysql` user
- PID file location: `/run/mariadb/mariadb.pid`
- Directory `/run/mariadb` already existed
- BUT:
  - Owner was `root`
  - Group was `mysql`
- Result:
  - `mysql` user could not write PID file
  - MariaDB exited even after successful startup steps

### Why this is critical
- MariaDB actually initialized successfully
- Failure happened **at the final step**
- Without PID file, systemd treats service as failed

---

## 🧠 Why `/run` Causes These Issues

- `/run` is a **tmpfs (temporary filesystem)**
- Recreated on:
  - reboot
  - crash
  - lab restart
- Ownership and permissions can reset
- Services depending on `/run` must reassert permissions

This makes `/run` a **common source of production issues**.

---

## 🛠️ Final Fix (Minimal & Correct)

Since the directory already existed, **no creation was needed**.

Only ownership was corrected:

```bash
sudo chown mysql:mysql /run/mariadb
```

(No chmod change was required.)

Then:

```bash
sudo systemctl start mariadb
```

Result:
- MariaDB started successfully
- Application connectivity restored

---

## ✅ Final Verification

```bash
sudo systemctl status mariadb
```

Confirmed:
```
Active: active (running)
```

---

## 🧠 Key Lessons (Important for Future)

1. systemd shows *that* a service failed, not *why*
2. Always check **application logs** for real errors
3. PID file permission issues can kill otherwise healthy services
4. `/run` is volatile — expect permission resets
5. Read logs **top to bottom**, but trust the **last ERROR**
6. Simple fixes often hide behind complex-looking logs

---

## 🔁 Mental Debugging Flow (Reusable)

1. Check service status (symptom)
2. Move to application logs (cause)
3. Identify permission / file / socket errors
4. Apply minimal fix
5. Verify and close incident

---

## 📌 Final Note

This task looked complex due to noisy logs and environment behavior,
but the actual issue was simple and realistic.

The key skill demonstrated was **knowing where to look and when to switch layers**.

---

**Day 09 – Notes completed**
