
# IPtables Installation And Configuration

## Task Overview
As part of Day 13 of the 100 Days of DevOps challenge, the goal was to secure the application port **3000** on all app servers by introducing a firewall layer using **iptables**.

### Security Requirements
- Install iptables and required dependencies
- Allow inbound access to port **3000** only from the **LBR host**
- Block access to port 3000 from all other sources
- Ensure firewall rules persist after reboot

---

## Environment Details
- OS: CentOS Stream 9
- Servers: stapp01, stapp02, stapp03
- Restricted Port: 3000
- Allowed Source: LBR host only

---

## Step 1: Identify LBR Host IP
Run this on any server:
```bash
getent hosts lbr
```

Example output:
```text
172.16.238.10 lbr
```

Note this IP for later steps.

---

## Step 2: Install iptables
Run the following on **each app server**:
```bash
sudo yum install -y iptables iptables-services
```

Verify installation:
```bash
iptables --version
```

---

## Step 3: Verify Existing Rules (Best Practice)
```bash
sudo iptables -L -n -v
```

This helps understand the current firewall state before making changes. based on the existing rules, decide whether Append or insert the rules. If it iptables is newly installed and in active state, mostly there would be an default reject rule in there, so Insert the rule before that default reject rule. below command is for appending the rule. 

---

## Step 4: Allow Port 3000 From LBR Only
```bash
sudo iptables -A INPUT -p tcp -s 172.16.238.10 --dport 3000 -j ACCEPT
```

---

## Step 5: Block Port 3000 From All Other Sources
```bash
sudo iptables -A INPUT -p tcp --dport 3000 -j DROP
```

This ensures only the LBR host can access the application.

---

## Step 6: Verify Rule Order
```bash
sudo iptables -L INPUT -n --line-numbers
```

Expected logic:
- ACCEPT traffic from LBR to port 3000
- DROP all other traffic to port 3000

---

## Step 7: Persist iptables Rules (Critical)
On CentOS Stream 9, iptables rules must be saved manually to survive reboot.

```bash
sudo iptables-save | sudo tee /etc/sysconfig/iptables
```

Verify:
```bash
sudo cat /etc/sysconfig/iptables
```

---

## Step 8: Validation

### From LBR Host (Should Work)
```bash
curl http://stapp01:3000
```
OR
```bash
telnet stapp01 3000
```

### From Any Other Host (Should Fail)
```bash
curl http://stapp01:3000
```
OR
```bash
telnet stapp01 3000
```

---
## Automation
- To automate this task using ansible go through this documentation - https://github.com/Thangamani22/100-days-of-devops/blob/main/100-days-of-devops-side-quests/Side-Quest-Ansible-Foundations/Day-13-IPtables-installation-and-config-using-Ansible.md

## Final Outcome
- iptables installed successfully
- Port 3000 secured using allowlist-based firewall rules
- Access restricted to LBR host only
- Firewall rules persist after reboot
- No unnecessary services or ports exposed

---

## Key Learnings
- iptables rules are evaluated top-to-bottom
- Allow rules must come before deny rules
- iptables is not a systemd service on CentOS Stream 9
- Persistence is as important as rule creation
- Manual validation helps avoid automation mistakes

---

## Summary
Implemented host-based firewall security using iptables by restricting application access to a specific source IP and ensuring rule persistence, following production-grade security practices.
