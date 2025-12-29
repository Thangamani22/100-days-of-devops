# Day 10 – Automating Website Media Backup with Bash

## 📌 Scenario
The production support team needed a reliable backup solution for a static website running on **App Server 3**.  
The task was to automate media backups using a **bash script**, without using sudo and without manual password prompts.

---

## 🎯 Objective
- Create a compressed backup of website media files
- Store the backup locally for short-term retention
- Copy the backup securely to a remote backup server
- Ensure the script runs non-interactively

---

## 🛠️ Environment
- **Source Server**: App Server 3
- **Website Path**: `/var/www/html/media`
- **Local Backup Path**: `/backup`
- **Remote Backup Server**: Nautilus Backup Server
- **Backup Method**: `zip` + `scp`
- **Authentication**: SSH key-based (passwordless)

---

## 📜 Script Overview
The script performs:
1. Navigation to the local backup directory
2. Creation of a zip archive of website media files
3. Secure copy of the archive to the backup server

---

## 🧩 Implementation

```bash
#!/bin/bash

BACKUP_DIR="/backup"
ZIP_NAME="xfusioncorp_media.zip"
MEDIA_DIR="/var/www/html/media"
BACKUP_SERVER_USER="clint"
BACKUP_SERVER_IP="172.16.238.16"
REMOTE_BACKUP_DIR="/backup"

cd "$BACKUP_DIR" || exit 1

zip -r "$ZIP_NAME" "$MEDIA_DIR"

scp "$ZIP_NAME" ${BACKUP_SERVER_USER}@${BACKUP_SERVER_IP}:${REMOTE_BACKUP_DIR}
```

---

## 🔐 Prerequisites
- `zip` package installed on App Server 3
- Passwordless SSH configured between App Server 3 and Backup Server
- `/backup` directory exists on both servers
- Script placed under `/scripts`
- Execute permission applied

```bash
chmod +x /scripts/media_backup.sh
```

---

## ✅ Result
- Media directory archived successfully
- Backup stored locally and remotely
- Script executed without sudo or password prompts

---

## 🧠 Key Takeaways
- Bash scripting enables simple yet effective automation
- SSH key-based authentication is critical for non-interactive jobs
- Avoiding sudo inside scripts improves safety and portability

---

## 💼 Skills Demonstrated
- Bash scripting
- Backup automation
- Secure file transfer
- Linux filesystem management

---

**Status:** ✅ Completed  
**Day 10 of #100DaysOfDevOps**
