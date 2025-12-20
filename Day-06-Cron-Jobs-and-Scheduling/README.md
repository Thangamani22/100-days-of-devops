# Day 06 – Cron Jobs and Task Scheduling in Linux

This README documents **Task 6** and the learning gained around **cron jobs**, scheduling, and automation in Linux.
It is structured for **easy revision** and **real-world understanding**.

---

## Part 1: Task 6 – Cron Job Setup on App Servers

### Task Overview

The Nautilus system admins team wants to automate day-to-day tasks using scripts deployed on all application servers.
Before deploying production scripts, a **sample cron job** is used to validate scheduling functionality.

The task requirements were:

- Install the `cronie` package on all app servers
- Start and enable the cron daemon (`crond`)
- Configure a cron job for the **root user**
- Schedule the job to run every 5 minutes
- Write output to a file for validation

---

### Step 1: Install Cron Package

On RHEL-based systems, cron is provided by the `cronie` package.

```bash
sudo yum install -y cronie
```

This package provides:
- The cron daemon (`crond`)
- Cron management utilities

---

### Step 2: Start and Enable Cron Service

```bash
sudo systemctl start crond
sudo systemctl enable crond
```

Verify service status:

```bash
systemctl status crond
```

---

### Step 3: Add Cron Job for Root User

The required cron job:

```cron
*/5 * * * * echo hello > /tmp/cron_text
```

This job:
- Runs every 5 minutes
- Executes as root
- Writes output to `/tmp/cron_text`
- Overwrites the file each time

---

### Method 1: Interactive (Recommended)

```bash
sudo crontab -e
```

Add the cron entry and save the file.

---

### Method 2: Non-Interactive (Advanced)

```bash
echo "*/5 * * * * echo hello > /tmp/cron_text" | sudo crontab -
```

⚠️ This replaces the entire root crontab.

---

### Verification

```bash
cat /tmp/cron_text
```

Expected output:

```text
hello
```

---

## Part 2: What I Learned – Cron Jobs and Scheduling Concepts

### What Is Cron

Cron is a **time-based job scheduler** in Linux that executes commands automatically at scheduled times.

---

### How Cron Works

- `crond` runs as a background daemon
- Crontab files store user schedules
- Jobs run with the privileges of the crontab owner

---

### Cron Expression Format

```text
* * * * *
| | | | |
| | | | └── Day of week (0–7)
| | | └──── Month (1–12)
| | └────── Day of month (1–31)
| └──────── Hour (0–23)
└────────── Minute (0–59)
```

Example:

```text
*/5 * * * *
```

Runs every 5 minutes.

---

### Root vs User Cron Jobs

- Each user has a separate crontab
- Root cron jobs are used for system-level automation
- Jobs inherit the user’s privileges

---

### Definition: sudo crontab -

```bash
sudo crontab -
```

Meaning:
- Runs `crontab` as root
- Reads cron entries from standard input
- Replaces the root user’s crontab

Used for automation, but risky if misused.

---

### Common Cron Mistakes

- Cron service not running
- Editing wrong crontab
- Using relative paths
- Assuming environment variables exist

---

## Conclusion

Cron is a core automation tool in Linux and DevOps.
Understanding how scheduling, user context, and execution work is essential for reliable automation.

Day 06 completed.
