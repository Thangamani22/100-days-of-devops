# Day 03 – Disable Direct Root SSH Login

## Task Overview

As part of security hardening activities, the security team at xFusionCorp Industries introduced a policy to **disable direct SSH login for the root user**.

The objective of this task is to ensure that all administrative access happens through **named users with sudo privileges**, instead of allowing direct root access.

---

## Goal of This Task

- Prevent direct SSH access to the root account
- Reduce attack surface on servers
- Improve auditability and accountability
- Follow enterprise security best practices

---

## Why This Is Important

Allowing direct root SSH login is considered a security risk because:

- The root user has unrestricted privileges
- Attackers commonly target the `root` account for brute-force attacks
- Root logins cannot be easily traced back to an individual
- It violates security compliance standards (CIS, NIST, ISO)

In production environments, administrators should:
- Log in using a normal user account
- Elevate privileges only when required using `sudo`

---

## Real-World Scenario

In enterprise systems:

- Direct root SSH access is disabled by default
- Each engineer logs in with a personal account
- All privileged actions are tracked via sudo logs

This approach improves:
- Security
- Accountability
- Incident investigation
- Compliance readiness

---

## How It Works in Linux

SSH behavior is controlled by the SSH daemon configuration file:
```bash
/etc/ssh/sshd_config
```
The key parameter is:

PermitRootLogin


Setting it to `no` blocks all direct root login attempts.

---

## Implementation Steps

### 1. Update SSH Configuration

Edit the SSH daemon configuration:

```bash
```bash
sudo vi /etc/ssh/sshd_config
```
*** Set the following value:

PermitRootLogin no

### 2. Validate Configuration

Before applying changes, validate the configuration:
```bash
sudo sshd -t
```
No output confirms the configuration is valid.

### 3. Restart SSH Service

Apply the changes:
```bash
sudo systemctl restart sshd
```
### Verification

Check the effective SSH configuration:
```bash
sudo sshd -T | grep permitrootlogin
```
Expected output:

permitrootlogin no

Test root SSH access (should fail):

ssh root@<server-name>

### Conclusion

Disabling direct root SSH login is a fundamental security practice in real-world DevOps environments.
This task reinforces secure access design and operational discipline.

### Day 03 completed.
