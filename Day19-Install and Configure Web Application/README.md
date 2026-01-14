
# Day 19 – Install and Configure Web Application (DocumentRoot Method)

## Objective
Prepare an Apache web server to host two static websites using Apache's default **DocumentRoot-based URL mapping**, without using Alias or VirtualHosts.

---

## Task Summary
- Install Apache on App Server 1
- Configure Apache to listen on port **8082**
- Deploy two static website backups:
  - `official`
  - `demo`
- Serve them using Apache DocumentRoot
- Validate using `curl`

---

## Architecture Overview
- **Jump Host**: Contains website backups  
  - `/home/thor/official`
  - `/home/thor/demo`
- **App Server 1**: Apache Web Server
  - DocumentRoot: `/var/www/html`
- **Access URLs**:
  - `http://localhost:8082/official/`
  - `http://localhost:8082/demo/`

---

## Step 1: Install Apache on App Server

```bash
sudo yum install -y httpd
```

**Purpose:**  
Installs the Apache HTTP Server package.

---

## Step 2: Configure Apache to Use Port 8082

Edit Apache configuration file:

```bash
sudo vi /etc/httpd/conf/httpd.conf
```

Update the listening port:

```apache
Listen 8082
```

Ensure DocumentRoot is set correctly:

```apache
DocumentRoot "/var/www/html"
DirectoryIndex index.html index.htm
```

**Purpose:**  
Configures Apache to accept HTTP requests on port **8082**.

---

## Step 3: Start and Enable Apache

```bash
sudo systemctl start httpd
sudo systemctl enable httpd
```

Verify Apache is listening on the correct port:

```bash
ss -tulnp | grep 8082
```

---

## Step 4: Copy Website Backups from Jump Host

Since Apache serves content from DocumentRoot, website files must be placed under `/var/www/html`.

Run on **jump_host**:

```bash
scp -r /home/thor/official app_server:/var/www/html/
scp -r /home/thor/demo app_server:/var/www/html/
```

Resulting structure on App Server:

```text
/var/www/html/official
/var/www/html/demo
```

---

## Step 5: Set Correct Ownership and Permissions

```bash
sudo chown -R apache:apache /var/www/html/official /var/www/html/demo
sudo chmod -R 755 /var/www/html/official /var/www/html/demo
```

**Purpose:**  
Ensures Apache has permission to read and serve website files.

---

## Step 6: Restart Apache

```bash
sudo systemctl restart httpd
```

---

## Step 7: Validate Using curl (Required)

Test official site:

```bash
curl http://localhost:8082/official/
```

Test demo site:

```bash
curl http://localhost:8082/demo/
```

**Expected Result:**  
HTML content or directory listing is returned successfully.

---

## Key Learnings
- Apache automatically maps URL paths to subdirectories inside DocumentRoot
- No additional configuration is required when content resides under DocumentRoot
- This method is simple and effective for basic static hosting
- Alias or VirtualHosts are used when content must live outside DocumentRoot

---

## Status
✅ **Day 19 task completed successfully using DocumentRoot method**
