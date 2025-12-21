# Day 07 – Password-less SSH Authentication (Linux SSH Study Guide)

This README serves two purposes:

1. Task 7 execution guide – what was required and how it was implemented  
2. SSH study guide – a deep, conceptual explanation of how SSH works in real systems  

This document is written as a **revision and learning guide** for Linux SSH fundamentals, automation, and DevOps usage.

---

## Part 1: Task 7 – Password-less SSH Setup Using SSH Keys

### Task Overview

The xFusionCorp Industries system admins team runs automation scripts from a **jump host** that must connect to all application servers in the Stratos Datacenter.

To enable reliable automation, the requirement was:

- Source system: Jump host  
- Source user: `thor`  
- Target systems: All app servers  
- Target users: Their respective **sudo users** (example: `tony` for App Server 1)  
- Authentication type: **Password-less SSH**  

The goal is to allow scripts to run without manual password input.

---

### Why This Task Is Important

Automation tools cannot type passwords.

Password-less SSH is required for:
- Cron jobs  
- Ansible  
- CI/CD pipelines  
- Monitoring and backup scripts  

Key-based authentication is secure, scalable, and industry standard.

---

### Implementation Steps

#### Step 1: Login to Jump Host as thor

```bash
ssh thor@jump-host
```

All SSH keys must belong to the **thor** user.

---

#### Step 2: Generate SSH Key Pair (If Not Already Present)

```bash
ssh-keygen
```

This creates:
- `~/.ssh/id_rsa` → private key  
- `~/.ssh/id_rsa.pub` → public key  

No passphrase was used to allow automation.

---

#### Step 3: Copy Public Key to App Server User

Example for App Server 1:

```bash
ssh-copy-id tony@app-server-1
```

This copies the public key to:

```text
/home/tony/.ssh/authorized_keys
```

---

#### Step 4: Verify Password-less SSH

```bash
ssh tony@app-server-1
```

If no password prompt appears, authentication is successful.

Repeat the same steps for all app servers using their respective sudo users.

---

## Part 2: SSH Fundamentals – Study & Revision Guide

This section explains **everything learned conceptually** during Day 7.

---

## What SSH Is (At Its Core)

SSH (Secure Shell) is a software protocol that provides:

1. Secure communication over an untrusted network  
2. Encrypted data transfer  
3. Strong user authentication  

SSH runs **on top of TCP (port 22)**.

TCP handles delivery. SSH handles security.

---

## Two Separate Jobs Performed by SSH

SSH clearly separates its responsibilities:

### 1. Secure Tunnel (Encryption)

- Uses symmetric encryption (AES, ChaCha20)  
- Protects all commands, output, and data  
- Uses temporary session keys  

### 2. Authentication (Identity)

- Uses asymmetric cryptography (public/private keys)  
- Proves who the user is  
- Does not encrypt bulk data  

Public/private keys are **identity tools**, not session encryption tools.

---

## What Public and Private Keys Really Are

SSH keys represent a **mathematical identity**.

- Private key → proof of identity (never shared)  
- Public key → verification material (safe to share)  

They are primarily used for:
- Digital signing  
- Authentication  
- Trust establishment  

---

## How SSH Authentication Works (Beginner-Level Flow)

1. Client initiates SSH connection  
2. Secure encrypted tunnel is established  
3. Client offers a public key  
4. Server checks `authorized_keys`  
5. Server sends a random challenge  
6. Client signs the challenge using private key  
7. Server verifies signature using public key  
8. Access granted without password  

At no point is the private key transmitted.

---

## What Is Actually Encrypted and How

- SSH first establishes a shared **session key**  
- Session key uses symmetric encryption  
- All traffic is encrypted using this key  

Public/private keys are used only for:
- Key exchange  
- Authentication  
- Signing  

They are not used to encrypt the full SSH session.

---

## Multiple Keys: Client and Server Behavior

### Multiple Private Keys on Client

- SSH client tries keys one by one  
- Default keys are auto-detected  
- `-i` is used when multiple keys exist  

### Multiple Public Keys on Server

- All stored in `authorized_keys`  
- Server checks if any key matches  
- First valid match allows access  

The server never chooses a key.
The client proposes keys.

---

## Why SSH Does Not Always Require `-i`

SSH automatically checks:
- `~/.ssh/id_ed25519`  
- `~/.ssh/id_rsa`  

`-i` is needed only for:
- Non-standard key names  
- Multiple identities  
- Advanced configurations  

---

## Password Authentication vs SSH Key Authentication

Passwords:
- Designed for humans  
- Risky in automation  
- Easily leaked  

SSH keys:
- Designed for machines  
- Secure and auditable  
- Required for automation  

Golden rule:
Passwords are for humans.
SSH keys are for automation.

---

## Manual SSH Key Setup (Without ssh-copy-id)

This explains what `ssh-copy-id` automates:

1. Create `~/.ssh` on server  
2. Set permissions to 700  
3. Create `authorized_keys`  
4. Set permissions to 600  
5. Append public key  

Understanding this removes SSH confusion.

---

## SSH and Cloud Key Pairs (AWS / Azure Comparison)

Cloud VMs:
- Public key injected at VM creation  
- Password often disabled  
- SSH key only authentication  

Day 7 task:
- Password exists  
- SSH key added later  
- Both authentication methods allowed  

Same mechanism, different timing.

---

## Why Jump Hosts Are Used

Jump hosts:
- Act as controlled entry points  
- Reduce attack surface  
- Centralize automation access  

This pattern is widely used in enterprises.

---

## Debugging Mental Model

When SSH fails, check in this order:

1. Correct user  
2. SSH service running  
3. Key permissions  
4. Key presence in authorized_keys  
5. Correct private key used  

---

## Why This Matters for DevOps

SSH is foundational for:
- Ansible  
- CI/CD pipelines  
- Cloud provisioning  
- Remote automation  

If SSH is unclear, all automation feels difficult.

---

## Final Takeaway

SSH is not magic.

It is:
- TCP for transport  
- Symmetric encryption for privacy  
- Asymmetric cryptography for identity  

Understanding this removes fear and builds confidence.

Day 07 completed.
