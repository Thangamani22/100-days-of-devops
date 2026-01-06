
# Day 14 – Apache Service Troubleshooting and Validation

## Task Overview
As part of Day 14 of the **100 Days of DevOps** challenge, the monitoring system reported that the **Apache service was unavailable** on one of the application servers in the Stratos Data Center.

### Objective
- Identify the faulty application server
- Ensure Apache service is running on all app servers
- Ensure Apache is listening on port **6400** on all app servers
- No application code validation required

---

## Environment Details
- OS: Linux (Stratos DC)
- App Servers: stapp01, stapp02, stapp03
- Service: Apache (`httpd`)
- Required Port: 6400

---

## Step 1: Check Apache Service Status
Run on each app server:
```bash
sudo systemctl status httpd
```

Purpose:
- Confirm whether Apache is running
- Identify startup or runtime issues

---

## Step 2: Check Port Usage
To check if any process is using port 6400:
```bash
sudo ss -tulnp | grep 6400
```

---

## Step 3: Verify Apache Port Binding
To ensure Apache itself is bound to port 6400:
```bash
sudo ss -tulnp | grep httpd
```

Expected output:
```text
LISTEN 0 511 0.0.0.0:6400 users:(("httpd",pid=XXXX))
```

---

## Step 4: Resolve Port Conflict (If Found)
If another process was occupying port 6400:

```bash
sudo ss -tulnp | grep 6400
sudo kill <PID> # or stop the service
sudo systemctl restart httpd
```

## Step 5: Validate Across All App Servers
Repeat on all app servers:
```bash
sudo systemctl status httpd
sudo ss -tulnp | grep 6400
```

---

## Final Outcome
- Apache service running on all app servers
- Apache listening on port 6400
- Monitoring alert cleared successfully

---

## Key Learnings
- Service health includes correct port binding
- `ss -tulnp` is essential for troubleshooting
- Not all log messages indicate failures
- Monitoring tools rely on service + port availability

---

## Interview-Ready Summary
Resolved an Apache service availability alert by identifying a port conflict, validating service status, ensuring correct port binding, and confirming consistency across all application servers.

---

**Day 14 Completed Successfully ✅**
