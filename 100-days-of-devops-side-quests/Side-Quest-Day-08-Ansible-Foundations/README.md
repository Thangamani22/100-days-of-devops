# Day 08 – Ansible Side Quest  
## From Manual Linux Tasks to Real Automation (Complete Study & Revision Guide)

This document captures **everything I did beyond the official Day 08 task** of the *100 Days of DevOps* challenge.

The goal of this README is:
- To preserve learning so it does not fade
- To document every prerequisite and decision
- To serve as a future revision guide
- To demonstrate real-world DevOps thinking

---

## Context: Why This Side Quest Exists

The official Day 08 task introduced Ansible installation on a jump host.

After completing:
- Day 06 – Cron job (manual Linux)
- Day 07 – Password-less SSH setup

Ansible was introduced at the right moment, triggering a deeper exploration.

Because the free KodeKloud plan does not allow re-running labs once completed,
I rebuilt the entire environment from scratch on AWS to practice and validate everything.

---

## Infrastructure Built from Scratch (Prerequisites)

Servers created manually:
- 1 Jump Host (Ansible Controller)
- 3 App Servers (Managed Nodes)

All servers:
- Linux-based
- Reachable via SSH
- Secured using SSH key authentication

---

## User & Access Design

Users involved:
- thor → Jump Host (Ansible controller user)
- App servers → sudo-capable users

SSH keys generated on the jump host and copied to all app servers.
Password-less SSH verified before automation.

---

## Sudo Configuration for Automation

On each app server:

```bash
visudo
```

Added:

```
thor ALL=(ALL) NOPASSWD: ALL
```

This step is mandatory for Ansible automation.

---

## Why Ansible

Manual operations do not scale and introduce errors.
Ansible enables:
- Agentless automation
- SSH-based communication
- Idempotent execution
- State-driven configuration

---

## Ansible Installation (Official Day 08 Task)

Installed using pip3:

```bash
sudo pip3 install ansible
```

Verified using:

```bash
ansible --version
```

Root PATH was updated to include /usr/local/bin.

---

## Ansible Workspace Setup

```bash
mkdir -p ~/ansible
cd ~/ansible
```

## Inventory Configuration

```ini
[my_app_servers]
172.31.29.32
172.31.27.101
172.31.28.220
```

---

## Connectivity Test

```bash
ansible -i inventory.ini my_app_servers -m ping
```

---

## Ad-hoc Commands Used

### 1. Install cronie

```bash
ansible -i inventory.ini my_app_servers -m yum -a "name=cronie state=present" -b
```
**Key learning**
- Ansible checks current system state
- If already installed → changed: false
- Demonstrates idempotency

#### 1.1 Sudo Error & Fix (Troubleshooting)
**Error encountered**
```bash
Task failed: Missing sudo password
```
**Root cause**
- SSH access worked
- Sudo required a password (not allowed for automation)

**Fix applied on app servers**
```bash
visudo
```
**Added:**
```bash
thor ALL=(ALL) NOPASSWD: ALL
```
**Learning**
- Ansible automation requires password-less sudo
- This is standard in real production setups

#### 1.2 Drift Simulation & Correction
**Manual test (on one server):**
```bash
yum remove -y cronie
```
Re-ran Ansible install command.

```bash
rpm -q cronie
```
This will ensure whether cronie installed or not

**Observed**
- Broken server → *** changed: true ***
- Healthy servers → *** changed: false ***

**Learning**
- Ansible detects and fixes configuration drift
- Only touches what is broken


### 2. Start and enable crond

```bash
ansible -i inventory.ini my_app_servers -m service -a "name=crond state=started enabled=yes" -b
```

### 3. Create cron job

```bash
ansible -i inventory.ini my_app_servers -m cron -a "name='ansible test cron' minute='*/5' job='echo hello > /tmp/cron_text' user=root" -b
```

---

## Ad-hoc vs Playbooks

- Ad-hoc: One-time commands, testing, debugging
- Playbooks: YAML files, repeatable, version-controlled automation

---

## Playbook Used

```yaml
---
- name: Configure cron job on app servers
  hosts: my_app_servers
  become: yes

  tasks:
    - name: Install cronie package
      yum:
        name: cronie
        state: present

    - name: Start and enable crond service
      service:
        name: crond
        state: started
        enabled: yes

    - name: Create root cron job
      cron:
        name: "ansible test cron"
        minute: "*/5"
        job: "echo hello > /tmp/cron_text"
        user: root
```

---

**Run command:**
```bash
ansible-playbook -i inventory.ini cron_setup.yml
```
**Observed:**
- First run → changes applied
- Second run → no changes

**Key learning:**
- Playbooks enforce desired state
- Safe to run repeatedly

## Key Learnings

- Ansible enforces desired state
- Idempotency prevents unnecessary changes
- SSH and sudo design is critical
- Playbooks are production automation

---

## Outcome

Manual Linux cron task successfully automated with Ansible.
This side quest strengthens long-term DevOps fundamentals.

---

### Side Quest – Day 08 Completed.
