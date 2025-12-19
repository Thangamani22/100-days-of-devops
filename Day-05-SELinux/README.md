# Day 05 – SELinux: Task Execution and Conceptual Learning

This README is intentionally divided into two parts:

1. Task 5 – What needed to be done and why  
2. What I learned – Deep understanding of SELinux for future revision

The goal is not just task completion, but building long-term understanding.

---

## Part 1: Task 5 – SELinux Configuration on App Server 1

### Task Overview

Following a security audit, xFusionCorp Industries decided to enhance server security by introducing **SELinux**.

For initial testing on **App Server 1**, the requirements were:

- Install the required SELinux packages  
- Permanently disable SELinux for now  
- Do not reboot immediately  
- Ignore current runtime status  
- Ensure SELinux is disabled **after the next reboot**  

---

### Goal of the Task

- Prepare the system for SELinux usage  
- Control SELinux behavior persistently  
- Avoid unexpected behavior during active usage  
- Allow configuration changes before enabling SELinux later  

---

### Step 1: Install Required SELinux Packages

```bash
sudo yum install -y selinux-policy selinux-policy-targeted policycoreutils
```

Purpose of these packages:
- selinux-policy – Core SELinux rules  
- selinux-policy-targeted – Targeted policy used on most servers  
- policycoreutils – Management tools like getenforce, setenforce, restorecon  

---

### Step 2: Permanently Disable SELinux

Persistent SELinux behavior is controlled by:

```
/etc/selinux/config
```

Edit the file:

```bash
sudo vi /etc/selinux/config
```

Set the value to:

```text
SELINUX=disabled
```

This ensures SELinux is disabled **after reboot**.

---

### Important Notes

- setenforce was not used because it is temporary  
- getenforce output was ignored as instructed  
- No reboot was performed  
- The effect will apply during the scheduled maintenance reboot  

---

### Outcome of Task 5

- SELinux packages installed successfully  
- SELinux permanently disabled via configuration  
- System prepared for controlled SELinux enablement later  

---

## Part 2: What I Learned – SELinux Deep Dive & Revision Notes

This section documents everything learned conceptually during Task 5.

---

## What SELinux Is (Big Picture)

SELinux (Security-Enhanced Linux) is a **Mandatory Access Control (MAC)** system.

It adds an additional security decision layer beyond Linux file permissions.

Even if Linux permissions allow access, **SELinux can still deny it**.

---

## Linux Permissions vs SELinux

Linux permissions (DAC):
- Based on user, group, and mode bits  
- User-controlled  

SELinux (MAC):
- Policy-driven  
- System-enforced  
- Controls what processes are allowed to do  

SELinux augments traditional permissions.

---

## SELinux Modes Explained

Enforcing:
- Actively blocks policy violations  
- Logs denials  

Permissive:
- Logs violations without blocking  
- Used for testing and learning  

Disabled:
- SELinux not loaded  
- No enforcement or logging  

---

## Why SELinux Is Sometimes Disabled Temporarily

Disabling SELinux can be strategic:

- Allows safe application observation  
- Prevents unexpected outages  
- Enables policy tuning  

Correct approach:
Install → Observe → Configure → Enforce

---

## The Most Important Concept: SELinux Labels

SELinux trusts **labels**, not users or locations.

Labels are applied to:
- Files and directories  
- Processes  
- Ports  

Access is allowed only when labels and policy align.

---

## Why Moving Files Can Break Applications

Copied files keep their original SELinux labels.

Even with correct permissions, access can fail due to incorrect labels.

This behavior is intentional and security-focused.

---

## Who Decides SELinux Labels

Labels are defined by:
- SELinux policy  
- File context mappings  

Users typically do not assign labels manually.

---

## How Labels Are Applied and Fixed

Labels are managed using:
- restorecon  
- setfiles  
- semanage fcontext  

Correcting labels is the right fix for most SELinux issues.

---

## Why Applications Break with SELinux

Common causes:
- Incorrect file labels  
- Custom directories without context  
- Services using unauthorized ports  
- Enabling SELinux without preparation  

SELinux reveals configuration assumptions.

---

## SELinux and Ports

SELinux controls which processes can bind to ports.

Ports must be explicitly allowed by policy.

---

## Debugging Mental Model

When troubleshooting:

1. Check Linux permissions  
2. Check SELinux mode  
3. Check process label  
4. Check resource label  
5. Check policy alignment  

---

## Why This Knowledge Matters for DevOps

- Prevents unnecessary security disabling  
- Improves troubleshooting confidence  
- Enables secure-by-design systems  
- Aligns with enterprise standards  

---

## Final Takeaway

SELinux is a powerful security mechanism.

Understanding labels, modes, and policies turns SELinux from a blocker into a protector.

Day 05 completed.
