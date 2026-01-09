
# Day 15 – Setup SSL for Nginx

## Task Overview
As part of Day 15 of the **100 Days of DevOps** challenge, the requirement was to prepare **App Server 3** for application deployment by installing and configuring **Nginx with HTTPS** using a provided self-signed SSL certificate.

The focus of this task was on web server readiness, secure configuration, and validation from a remote host.

---

## Requirements
1. Install and configure Nginx on App Server 3
2. Deploy the provided self-signed SSL certificate and key
3. Create a basic index page
4. Validate HTTPS access from the jump host

---

## Environment Details
- Server: App Server 3 (stapp03)
- Web Server: Nginx
- SSL Type: Self-signed certificate
- SSL Files Provided:
  - /tmp/nautilus.crt
  - /tmp/nautilus.key

---

## Step 1: Install Nginx
```bash
sudo yum install -y nginx
```

Verify installation:
```bash
nginx -v
```

---

## Step 2: Start and Enable Nginx
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

Verify service status:
```bash
sudo systemctl status nginx
```

---

## Step 3: Prepare SSL Certificate Location
```bash
sudo mkdir -p /etc/nginx/ssl
sudo mv /tmp/nautilus.crt /etc/nginx/ssl/
sudo mv /tmp/nautilus.key /etc/nginx/ssl/
sudo chmod 644 /etc/nginx/ssl/nautilus.crt
sudo chmod 600 /etc/nginx/ssl/nautilus.key
```

---

## Step 4: Configure Nginx for HTTPS
```bash
sudo vi /etc/nginx/nginx.conf
```

Add the following server block inside the http block:
```nginx
server {
    listen 443 ssl;
    server_name _;

    ssl_certificate     /etc/nginx/ssl/nautilus.crt;
    ssl_certificate_key /etc/nginx/ssl/nautilus.key;

    root /usr/share/nginx/html;
    index index.html;
}
```

---

## Step 5: Create index.html
```bash
sudo vi /usr/share/nginx/html/index.html
```

Add:
```html
Welcome!
```

---

## Step 6: Test Nginx Configuration
```bash
sudo nginx -t
```

---

## Step 7: Reload Nginx
```bash
sudo systemctl reload nginx
```

---

## Step 8: Local HTTPS Test
```bash
curl -Ik https://localhost
```

---

## Step 9: Final Validation from Jump Host
```bash
curl -Ik https://stapp03
```

---

## Final Outcome
- Nginx installed and running
- HTTPS configured successfully
- SSL certificates deployed securely
- Access validated from jump host

---

## Key Learnings
- Proper SSL placement and permissions matter
- Always validate configs before reload
- Self-signed certs are common internally
- curl is effective for HTTPS validation

---

## Interview-Ready Summary
Configured Nginx with HTTPS using a self-signed certificate, validated configuration and remote access, and followed production-style deployment practices.

---

**Day 15 Completed Successfully ✅**
