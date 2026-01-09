
# Day 16 – Install and Configure Nginx as an LBR

## Task Overview
With increasing traffic on one of the Nautilus-managed websites, the production support team decided to migrate the application to a high availability architecture. As part of this migration, the final pending task was to configure the Load Balancer (LBR) server.

On Day 16 of the 100 Days of DevOps challenge, the objective was to configure Nginx as a Layer 7 (HTTP) Load Balancer, distributing traffic across all application servers without modifying their existing Apache configurations.

---

## Requirements
1. Install Nginx on the LBR server
2. Configure HTTP load balancing using all App Servers
3. Update only the main Nginx configuration file (/etc/nginx/nginx.conf)
4. Do not modify Apache ports on App Servers
5. Ensure Apache service is running on all App Servers
6. Validate access using the StaticApp button

---

## Environment Details
- Load Balancer: LBR server
- App Servers: stapp01, stapp02, stapp03
- Backend Web Server: Apache (httpd)
- Apache Listening Port: 3002
- Load Balancer Type: Nginx (Layer 7)

---

## Step 1: Verify Apache on All App Servers
```bash
ssh stapp01 "sudo systemctl status httpd"
ssh stapp02 "sudo systemctl status httpd"
ssh stapp03 "sudo systemctl status httpd"
```

---

## Step 2: Identify Apache Listening Port
```bash
sudo ss -tulnp | grep httpd
```

Confirmed listening port:
```
0.0.0.0:3002
```

---

## Step 3: Install Nginx on LBR
```bash
sudo yum install -y nginx
nginx -v
```

---

## Step 4: Start and Enable Nginx
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
```

---

## Step 5: Configure Load Balancing
Edit main configuration file:
```bash
sudo vi /etc/nginx/nginx.conf
```

### Upstream Configuration
```nginx
upstream app_servers {
    server stapp01:3002;
    server stapp02:3002;
    server stapp03:3002;
}
```

### Server Block Configuration
Default static server block was commented out to avoid serving local content.

```nginx
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://app_servers;
    }
}
```

---

## Step 6: Validate Configuration
```bash
sudo nginx -t
```

---

## Step 7: Reload Nginx
```bash
sudo systemctl reload nginx
```

---

## Step 8: Final Validation
- Access application via StaticApp button
- Or test from jump host:
```bash
curl http://lbr
```

---

## Final Outcome
- Nginx configured as HTTP load balancer
- Traffic distributed across all app servers
- Apache backend unchanged
- High availability achieved

---

## Key Learnings
- upstream defines backend server pools
- proxy_pass enables reverse proxy functionality
- Default Nginx static content must be disabled for load balancing
- Load balancers adapt to backend services

---

## Interview-Ready Summary
Configured Nginx as a Layer 7 load balancer using upstream servers to distribute traffic across multiple Apache backends without modifying application server configurations.

---

Day 16 Completed Successfully
