
# Day 18 – Configure LAMP server

## Objective
Deploy a basic WordPress-ready infrastructure using Apache, PHP, and MariaDB behind a Load Balancer, with shared storage across application servers.

---

## Architecture Overview
- **Storage Server**: Shared directory `/vaw/www/html`
- **App Servers**: Apache + PHP running on port `8086`
- **DB Server**: MariaDB
- **Load Balancer**: Routes traffic to app servers

---

## Step A: Install Apache and PHP on App Servers

### Command
```bash
sudo yum install -y httpd php php-mysqlnd php-gd php-xml php-mbstring
```

### Purpose
- `httpd`: Web server
- `php`: PHP runtime
- `php-mysqlnd`: Enables PHP–MySQL connectivity
- Other PHP modules: Required for WordPress compatibility

---

## Step B: Configure Apache to Run on Port 8086

### Edit Apache Config
```bash
sudo vi /etc/httpd/conf/httpd.conf
```

Change:
```apache
Listen 80
```
To:
```apache
Listen 8086
```

Ensure:
```apache
DocumentRoot "/var/www/html"
DirectoryIndex index.php index.html
```

### Restart Apache
```bash
sudo systemctl restart httpd
sudo systemctl enable httpd
```

### Verify
```bash
ss -tulnp | grep 8086
```

---

## Step C: Install MariaDB on DB Server

### Command
```bash
sudo yum install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

### Purpose
Installs and starts the database server for application data storage.

---

## Step D: Create Database and User

### Login to MariaDB
```bash
mysql -u root
```

### SQL Commands
```sql
CREATE DATABASE kodekloud_db8;
CREATE USER 'kodekloud_gem'@'%' IDENTIFIED BY 'B4zNgHA7Ya';
GRANT ALL PRIVILEGES ON kodekloud_db8.* TO 'kodekloud_gem'@'%';
FLUSH PRIVILEGES;
EXIT;
```

### Purpose
- Creates application database
- Creates dedicated DB user
- Grants full access for application operations

---

## Step E: Application Connectivity Test

### Create PHP File (on any App Server)
```bash
sudo vi /var/www/html/index.php
```

### PHP Code
```php
<?php
$conn = new mysqli("DB_SERVER_HOSTNAME", "kodekloud_gem", "B4zNgHA7Ya", "kodekloud_db8");

if ($conn->connect_error) {
    die("Database Connection Failed");
}
echo "App is able to connect to the database using user kodekloud_gem";
?>
```

### Purpose
- Verifies end-to-end connectivity
- Confirms Apache, PHP, DB, storage, and network are working together

---

## Final Validation

- Open **App** button via Load Balancer
- Expected Output:
```
App is able to connect to the database using user kodekloud_gem
```

---

## Key Learnings
- Shared storage ensures consistency across app servers
- Application-level validation is critical
- Separation of App, DB, and Storage follows real-world architecture

---

✅ **Task completed successfully (Manual Execution)**  
📌 *Ansible automation can be implemented later for full automation.*
