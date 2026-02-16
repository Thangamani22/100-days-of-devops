# Day 40 – Configure Apache Inside a Running Docker Container

## 📌 Objective
Complete pending service configuration inside a running Docker container when the original owner is unavailable.

Tasks:
- Install Apache inside the container
- Configure Apache to listen on port **8089**
- Ensure Apache service is running
- Keep the container running at the end

---

## 🧠 Scenario Overview
- Server: App Server 3 (Stratos Datacenter)
- Running container: `kkloud`
- OS inside container: Ubuntu 18.04–based (minimal image)
- Requirement urgency: Operational fix while team member is on PTO

---

## 🔑 Key Concepts Applied

### 1️⃣ Working inside a running container
Used `docker exec` to access the container and perform live configuration instead of rebuilding an image.

### 2️⃣ Minimal container images
The container did not include common utilities like:
- `vi`
- `ss`
- `netstat`

This is expected behavior in minimal images.

---

## ✅ Steps Performed

### 1️⃣ Verify container is running
```bash
sudo docker ps
```

---

### 2️⃣ Access the container
```bash
sudo docker exec -it kkloud bash
```

---

### 3️⃣ Update package list
```bash
apt update
```

---

### 4️⃣ Install Apache
```bash
apt install -y httpd
```

> Note: Although the container reports Ubuntu, it exposes Red Hat–style Apache packaging (`httpd`), which was verified at runtime.

---

### 5️⃣ Edit Apache port configuration
Since `vi` was not available initially, it was installed to allow configuration editing.

```bash
apt install -y vim
```

Edited file:
```bash
/etc/apache2/ports.conf
```

Changed:
```text
Listen 80
```

To:
```text
Listen 8089
```

This ensures Apache listens on **all interfaces**, not a specific IP.

---

### 6️⃣ Restart Apache service
```bash
service httpd restart
```

---

### 7️⃣ Verify Apache service status
```bash
service httpd status
```

Confirmed Apache is **active (running)**.

---

## 🧠 Verification Without Extra Tools
Networking tools like `ss` and `netstat` were intentionally not installed.

Verification was done using:
- Apache service status
- Apache-native configuration behavior

This aligns with minimal-container best practices.

---

## 🧠 Key Learnings
- Containers often lack debugging tools by design
- Installing editors like `vi` is acceptable when configuration changes are required
- Avoid installing unnecessary networking tools unless explicitly needed
- Operational fixes can be safely done using `docker exec` for urgent cases

---

## 🏁 Outcome
✔️ Apache installed successfully  
✔️ Apache configured to listen on port 8089  
✔️ Service running inside the container  
✔️ Container left in running state  

---

## ✅ Status
**Day 40 task completed successfully** 🚀
