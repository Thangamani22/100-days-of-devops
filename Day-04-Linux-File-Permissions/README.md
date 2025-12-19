# Day 04 – Grant Execute Permission to a Script

## Task Overview

As part of automating backup processes, a bash script named `xfusioncorp.sh` was distributed to servers.  
However, the script lacked executable permissions on **App Server 1**.

The task is to:
- Grant executable permission to the script
- Ensure **all users** can execute it

Script location:
```bash
/tmp/xfusioncorp.sh
```

---

## Goal

- Understand Linux file permission behavior
- Grant execute permission safely
- Ensure the script can be executed by any user

---

## Why This Matters

In Linux, scripts do not run just because they exist.  
They must explicitly have **execute (`x`) permission**.

Missing execute permission is a common cause of failures in:
- Backup jobs
- Cron tasks
- Automation scripts
- CI/CD pipelines

This makes file permissions a **core Linux and DevOps concept**.

---

## Linux File Permission Basics

Each file has three permission types:
- `r` – read
- `w` – write
- `x` – execute

Permissions are applied to three categories:
- Owner (user)
- Group
- Others

Execute permission determines whether a file can be run as a command.

---

## Implementation Steps

### Step 1: Check Existing Permissions

```bash
ls -l /tmp/xfusioncorp.sh
```
Example output:
-rw-r--r-- 1 root root xfusioncorp.sh
This indicates the script is not executable.

Step 2: Grant Execute Permission to All Users
chmod a+x /tmp/xfusioncorp.sh


Explanation:

chmod → change file permissions

a → all users (owner, group, others)

+x → add execute permission

This adds execute access without removing existing permissions.

Step 3: Verify Updated Permissions
ls -l /tmp/xfusioncorp.sh


Expected output:

-rwxr-xr-x 1 root root xfusioncorp.sh


This confirms that all users can execute the script.

Step 4: Test Script Execution
/tmp/xfusioncorp.sh


The script should now run successfully.

What I Learned

This task helped me revise Linux file permission concepts and clearly understand:

How read, write, and execute permissions work

How permissions differ for users, groups, and others

Why execute permission is mandatory for running scripts

It reinforced the importance of mastering fundamentals that directly impact real-world automation.

Key Takeaways

Linux enforces execution through permissions

chmod a+x is a safe way to grant execute access

Always verify permissions before troubleshooting scripts

Small permission issues can break critical automation

Conclusion

Granting execute permission is a simple but essential Linux operation.
This task reinforced foundational knowledge that every DevOps engineer relies on daily.

Day 04 completed.