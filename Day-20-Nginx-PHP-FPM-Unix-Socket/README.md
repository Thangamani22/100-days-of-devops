
# Day 20 – Configure Nginx + PHP-FPM Using Unix Socket

## Objective
Prepare a production-style environment to run a PHP-based application using **Nginx + PHP-FPM** on **App Server 2**, following modern best practices.  
The goal is to understand **how Nginx and PHP-FPM work together**, why Unix sockets are used, and how PHP requests are handled end-to-end.

---

## Architecture Overview (Conceptual)

```
Client (curl from jump host)
        |
        v
Nginx (Port 8092)
        |
        v
Unix Socket (/var/run/php-fpm/default.sock)
        |
        v
PHP-FPM 8.2 (PHP execution engine)
        |
        v
index.php / info.php
```

---

## Key Concepts (Beginner Friendly)

### What is PHP-FPM?
PHP-FPM (FastCGI Process Manager) is **not a web server**.  
It is a **PHP execution service** that runs PHP scripts when requested by a web server like Nginx.

- Nginx handles HTTP requests
- PHP-FPM executes PHP code
- Communication happens using **FastCGI**

---

### Why Nginx + PHP-FPM?
- Separation of concerns (web server vs PHP runtime)
- Better performance and scalability
- Industry-standard setup for PHP applications

---

### Why Unix Socket?
We use:
```
/var/run/php-fpm/default.sock
```

Benefits:
- Faster than TCP (no network overhead)
- More secure (filesystem permissions)
- Best practice when Nginx and PHP-FPM run on the same server

---

## Task Requirements Mapping

| Requirement | What it Means |
|---|---|
| Install Nginx | Web server to serve HTTP traffic |
| Port 8092 | Custom application port |
| DocumentRoot | `/var/www/html` |
| PHP-FPM 8.2 | PHP execution engine |
| Unix socket | Nginx ↔ PHP-FPM communication |
| curl test | Validate infra, not browser behavior |

---

## Step-by-Step Execution (With Purpose)

### Step 1: Install Nginx
```bash
sudo yum install -y nginx
```
**Purpose:** Installs the web server that will accept HTTP requests.

---

### Step 2: Install PHP-FPM 8.2
```bash
sudo yum install -y epel-release
sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
sudo yum install -y php82 php82-php-fpm
```

**Purpose:**
- Default OS repos do not provide PHP 8.2
- Remi repository is the standard source for modern PHP versions

---

### Step 3: Create Runtime Directory for Socket
```bash
sudo mkdir -p /var/run/php-fpm
```

**Purpose:**
- PHP-FPM creates its Unix socket here
- A file cannot be created if its parent directory does not exist
- `/var/run` is used for runtime files and may be cleared on reboot

---

### Step 4: Configure PHP-FPM Socket
Edit the pool configuration:
```bash
sudo vi /etc/opt/remi/php82/php-fpm.d/www.conf
```

Set:
```ini
listen = /var/run/php-fpm/default.sock
listen.owner = nginx
listen.group = nginx
listen.mode = 0660

user = nginx
group = nginx
```

**Purpose:**
- Defines where PHP-FPM listens
- Ensures Nginx has permission to access the socket
- Runs PHP workers as the nginx user

Start PHP-FPM:
```bash
sudo systemctl start php82-php-fpm
sudo systemctl enable php82-php-fpm
```

---

### Step 5: Configure Nginx to Forward PHP Requests
Edit Nginx config:
```bash
sudo vi /etc/nginx/nginx.conf
```

Add inside `http {}`:
```nginx
server {
    listen 8092;
    server_name stapp02;

    root /var/www/html;
    index index.php index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php-fpm/default.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

**How Nginx Sends Traffic to PHP-FPM:**
- `.php` requests match `location ~ \.php$`
- `fastcgi_pass` forwards the request to PHP-FPM
- `SCRIPT_FILENAME` tells PHP which file to execute

---

### Step 6: Start Nginx
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

Validate configuration:
```bash
sudo nginx -t
```

---

### Step 7: Validation (Required)
From **jump host**:
```bash
curl http://stapp02:8092/index.php
curl http://stapp02:8092/info.php
```

**Expected Result:**
- PHP output is returned
- No raw PHP code
- No 404 or 502 errors

---

## Common Errors & Meaning

| Error | Meaning |
|---|---|
| 404 | Nginx cannot find the file |
| 502 | Nginx cannot talk to PHP-FPM |
| Raw PHP shown | PHP-FPM not connected |

---

## Note on Lab-Specific Behavior
In this lab environment, the PHP-FPM socket ownership required a temporary manual fix (`chown nginx:nginx`) to complete the task.  
Conceptually, the correct approach is configuring ownership in `www.conf`.  
This behavior may differ in real or rebooted environments.

---

## Key Learnings
- Nginx does not execute PHP
- PHP-FPM is the PHP execution engine
- Unix sockets provide fast, secure communication
- FastCGI configuration is the glue between Nginx and PHP
- Understanding the flow is more important than memorizing commands

---

## Status
✅ **Day 20 task completed successfully**  
📘 *Concepts understood; deeper PHP-FPM internals to be explored later in a personal environment.*
