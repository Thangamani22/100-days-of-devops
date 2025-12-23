# Day 08 – Introduction to Ansible (Controller Setup & Basics)

This README documents **Day 08** of the 100 Days of DevOps challenge.  
It is written as both a **task execution guide** and a **beginner-friendly study note** for Ansible.

---

## Part 1: Task 8 – Install Ansible on Jump Host

### Task Overview

The Nautilus DevOps team decided to evaluate **Ansible** as an automation and configuration management tool.
To begin testing, the **jump host** was chosen as the **Ansible controller**.

### Requirements

- Install **Ansible version 4.7.0**
- Use **pip3 only**
- Ensure the Ansible binary is available **globally (all users)**

---

## Step-by-Step Implementation

### Step 1: Login to Jump Host

```bash
ssh thor@jump-host
```

---

### Step 2: Ensure pip3 Is Installed

```bash
pip3 --version
```

If not installed:

```bash
sudo yum install -y python3-pip
```

---

### Step 3: Install Ansible 4.7.0 Using pip3

```bash
sudo pip3 install ansible==4.7.0
```

Why `sudo`?
- Installs Ansible system-wide
- Makes it available to all users

---

### Step 4: Verify Ansible Installation

```bash
ansible --version
```

Expected output (example):

```text
ansible [core 2.11.x]
```

Note:
- Ansible **4.7.0 maps to ansible-core 2.11.x**
- This confirms the correct version

---

### Step 5: Verify Binary Location

```bash
which ansible
```

Expected:

```text
/usr/local/bin/ansible
```

---

### Step 6: Fix Root PATH Issue (If ansible Not Found for root)

When switching to root, `ansible` may not be found because `/usr/local/bin` is missing from root’s PATH.

Check PATH:

```bash
echo $PATH
```

Fix system-wide PATH:

```bash
sudo vi /etc/profile
```

Add:

```bash
export PATH=$PATH:/usr/local/bin
```

Reload:

```bash
source /etc/profile
```

Verify as root:

```bash
sudo su -
ansible --version
```

---

## Part 2: What I Learned – Ansible Fundamentals

### What Is Ansible

Ansible is an **agentless automation and configuration management tool**.

It allows you to:
- Run commands on multiple servers
- Apply configurations consistently
- Automate repetitive operational tasks

---

### Ansible Architecture

- **Controller**: Machine where Ansible is installed (Jump Host)
- **Managed Nodes**: Target servers (App Servers)
- **Connection**: SSH
- **Language**: YAML (playbooks)
- **Execution**: Python-based modules

No agents are installed on managed nodes.

---

### Why SSH Matters for Ansible

Ansible relies on:
- Password-less SSH
- Non-root sudo users
- Secure key-based authentication

This is why SSH setup (Day 7) is a prerequisite.

---

### Ansible Versioning Explained

- `ansible` → Meta package (collections + tooling)
- `ansible-core` → Execution engine

Example:
- Ansible 4.7.0
- ansible-core 2.11.x

Seeing `core 2.11.x` in output is correct.

---

### Why pip Instead of yum

- yum provides older versions
- pip allows precise version control
- Consistent across environments
- Preferred in DevOps teams

---

## Key Takeaways

- Ansible is agentless and SSH-based
- Jump host acts as Ansible controller
- pip-based installation gives version control
- PATH configuration is important for global access
- This setup enables real automation

---

## Conclusion

With Ansible installed and accessible globally, the jump host is now ready to:
- Run ad-hoc commands
- Manage multiple servers
- Execute playbooks

Day 08 completed.
