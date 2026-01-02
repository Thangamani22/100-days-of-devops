
# Day 12 – Apache Service Troubleshooting on Port 5000

## Task Summary
Apache service on App Server 1 (stapp01) was not reachable on port 5000 from the jump host.
The task was to identify and fix the issue without modifying index.html or compromising security.

---

## Issues Identified

### Issue 1: Apache Failed to Start (Port Conflict)

**Symptom**
```
sudo systemctl status httpd
```
Apache showed `Active: failed` with error:
```
(98) Address already in use: could not bind to address 0.0.0.0:5000
```

**Root Cause**
Another service was already using port 5000.

**Resolution**
Identify the process:
```
sudo netstat -tulnp | grep 5000
```
Stop the conflicting service or process:
```
sudo systemctl stop <service-name>
# or
sudo kill <PID>
```

Restart Apache:
```
sudo systemctl start httpd
sudo systemctl status httpd
```

---

### Issue 2: Apache Running but Not Reachable Externally (iptables)

**Symptom**
Local access worked:
```
curl http://localhost:5000
```
Remote access from jump host failed:
```
curl http://stapp01:5000
```

**Investigation**
Check iptables rules:
```
sudo iptables -L -n -v
```

iptables allowed only:
- Established connections
- ICMP
- Loopback
- SSH (port 22)

A final blanket REJECT rule blocked all other inbound traffic.

**Resolution**
Allow port 5000 before the REJECT rule:
```
sudo iptables -I INPUT 5 -p tcp --dport 5000 -j ACCEPT
```

Verify:
```
sudo iptables -L INPUT -n --line-numbers
```

Final test from jump host:
```
curl http://stapp01:5000
```

---

## Final Outcome
- Apache started successfully
- Port conflict resolved
- External access restored securely
- index.html unchanged
- No firewall disabled

---

## Interview-Ready Explanation
Apache initially failed due to a port conflict on 5000. After resolving it, Apache was reachable locally but blocked externally by restrictive iptables rules. Adding an explicit ACCEPT rule for port 5000 before the REJECT rule resolved the issue securely.
