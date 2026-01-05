
# Day 13 – IPtables Installation And Configuration Using Ansible

## Why This Task Is Special
Even though Day 13 is an independent task focused on configuring iptables across all application servers, I intentionally chose to automate this task using Ansible.

To make this possible, the learnings from **Day 7 (passwordless SSH)** and **Day 8 (Ansible installation and configuration)** were crucial. Revisiting those tasks helped me clearly understand why secure access, privilege management, and configuration consistency are foundational before introducing any automation tool.

This task gave me the opportunity not only to complete the firewall configuration, but also to practice Ansible in a real scenario and reinforce earlier concepts. In the process, I gained more confidence in using Ansible ad-hoc commands and gradually transitioning toward a playbook-based approach.

One thing I truly appreciate is how KodeKloud has designed the 100 Days of DevOps challenge. Before starting this journey, I didn’t clearly understand why tools like Ansible are used in real environments. But within just a few hands-on tasks, I was able to use Ansible independently across different scenarios.

This experience strongly reinforced one key lesson for me: doing hands-on tasks teaches far more than just watching tutorials. The learning sticks when you apply it yourself.

#### This README is intentionally divided into two halves:
1. Learning mode using Ansible ad-hoc commands
2. Automation mode using an Ansible playbook

---

## Task Objective
- Install iptables on all app servers
- Allow inbound access to port 3000 only from LBR
- Block port 3000 for all other sources
- Ensure rules persist after reboot
- Handle default REJECT rule by inserting rules at the correct position

---

# PART 1: Prerequisites (Day 7 & Day 8 Revision)

## Enable Passwordless SSH
```bash
ssh-keygen
ssh-copy-id tony@stapp01
ssh-copy-id steve@stapp02
ssh-copy-id banner@stapp03
```

## Configure Passwordless sudo
```bash
sudo visudo
```

Add:
```text
tony ALL=(ALL) NOPASSWD: ALL
steve ALL=(ALL) NOPASSWD: ALL
banner ALL=(ALL) NOPASSWD: ALL
```

## Install Ansible
```bash
sudo yum install -y ansible
ansible --version
```

## Inventory File
```ini
[app_servers]
stapp01 ansible_user=tony
stapp02 ansible_user=steve
stapp03 ansible_user=banner
```

Test:
```bash
ansible app_servers -m ping -i inventory.ini
```

---

# PART 2: Learning Mode – Ansible Ad-hoc Commands

## Identify LBR IP
```bash
getent hosts lbr
```
Save it for later. 

## Install iptables
```bash
ansible app_servers -i inventory.ini -b -m yum -a "name=iptables,iptables-services state=present"
```

## Start and Enable iptables Service
```bash
ansible app_servers -i inventory.ini -b -m service -a "name=iptables state=started enabled=yes"
```

## Verify Default Rules
```bash
ansible stapp01 -i inventory.ini -b -m command -a "iptables -L INPUT -n --line-numbers"
```

Default REJECT rule exists at position 5.

## Allow Port 3000 From LBR
```bash
ansible app_servers -i inventory.ini -b -m command -a "iptables -I INPUT 5 -p tcp -s 172.16.238.10 --dport 3000 -j ACCEPT"
```

## Block Port 3000 for Others
```bash
ansible app_servers -i inventory.ini -b -m command -a "iptables -I INPUT 6 -p tcp --dport 3000 -j DROP"
```

## Persist Rules
```bash
ansible app_servers -i inventory.ini -b -m shell -a "iptables-save | tee /etc/sysconfig/iptables"
```

---

# PART 3: Automation Mode – Ansible Playbook

## Playbook: day13-iptables.yml
```yaml
- name: Secure port 3000 using iptables
  hosts: app_servers
  become: yes
  vars:
    lbr_ip: 172.16.238.10

  tasks:
    - name: Install iptables packages
      yum:
        name:
          - iptables
          - iptables-services
        state: present

    - name: Start and enable iptables service
      service:
        name: iptables
        state: started
        enabled: yes

    - name: Allow port 3000 from LBR
      command: iptables -I INPUT 5 -p tcp -s {{ lbr_ip }} --dport 3000 -j ACCEPT

    - name: Block port 3000 for others
      command: iptables -I INPUT 6 -p tcp --dport 3000 -j DROP

    - name: Persist rules
      shell: iptables-save | tee /etc/sysconfig/iptables
```

Run:
```bash
ansible-playbook -i inventory.ini day13-iptables.yml
```

---

## Final Outcome
Firewall rules applied consistently across all app servers using Ansible.

## Interview-Ready Summary
Validated firewall logic using ad-hoc commands, then automated using an Ansible playbook after revisiting SSH and sudo fundamentals.
