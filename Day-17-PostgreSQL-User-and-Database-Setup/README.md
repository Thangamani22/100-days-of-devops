
# Day 17 – PostgreSQL User and Database Setup

## Task Overview
As part of Day 17 of the **100 Days of DevOps** challenge, the Nautilus application development team requested preparation of a PostgreSQL database server for a new application deployment.

The PostgreSQL service was already installed and running. The task focused purely on **database-level configuration**, with a strict instruction **not to restart the PostgreSQL service**, mirroring real production constraints.

---

## Requirements
1. Create a PostgreSQL database user `kodekloud_rin`
2. Set the password for the user to `LQfKeWWxWD`
3. Create a database named `kodekloud_db10`
4. Grant full privileges on the database to `kodekloud_rin`
5. Do **not** restart the PostgreSQL service

---

## Environment Details
- Database Server: Nautilus DB Server (stdb01)
- Database Engine: PostgreSQL 13
- Administrative OS User: `postgres`

---

## Step 1: Connect to the Database Server
```bash
ssh stdb01
```

---

## Step 2: Switch to postgres OS User
```bash
sudo su - postgres
```

---

## Step 3: Access PostgreSQL Shell
```bash
psql
```

Expected prompt:
```text
postgres=#
```

---

## Step 4: Create Database User (Role)
```sql
CREATE USER kodekloud_rin WITH PASSWORD 'LQfKeWWxWD';
```

Verify:
```sql
\du
```

---

## Step 5: Create Database
```sql
CREATE DATABASE kodekloud_db10;
```

Verify:
```sql
\l
```

---

## Step 6: Grant Full Privileges
```sql
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db10 TO kodekloud_rin;
```

---

## Optional Verification
```sql
\c kodekloud_db10
\q
```

---

## Final Outcome
- PostgreSQL user created
- Database created
- Privileges granted successfully
- No service restart performed

---

## Key Learnings
- PostgreSQL roles manage user access
- Database changes do not require service restarts
- Production DB work must minimize disruption

---

## Interview-Ready Summary
Created a PostgreSQL user and database and granted full privileges using SQL commands while adhering to production constraints by avoiding service restarts.

---

Day 17 Completed Successfully
