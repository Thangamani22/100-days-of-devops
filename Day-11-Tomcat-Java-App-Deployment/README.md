# Day 11 – Deploying a Java Application on Tomcat

## 📌 Scenario
The Nautilus application team completed the beta version of a Java-based application and decided to deploy it using **Apache Tomcat**.

The task was to install Tomcat on **App Server 3**, configure it to run on a custom port, deploy the application, and verify access via the base URL.

---

## 🎯 Objective
- Install Apache Tomcat
- Configure Tomcat to run on port **8085**
- Deploy a Java application (`ROOT.war`)
- Verify application accessibility

---

## 🛠️ Environment
- **Server**: App Server 3 (`stapp03`)
- **Application Server**: Apache Tomcat
- **Application Artifact**: `ROOT.war`
- **Source of WAR**: Jump Host (`/tmp/ROOT.war`)
- **Access URL**: `http://stapp03:8085`

---

## 🔧 Implementation Steps

### 1️⃣ Install Tomcat

```bash
sudo yum install -y tomcat
```

Verify installation:
```bash
rpm -qa | grep tomcat
```

---

### 2️⃣ Configure Tomcat to run on port 8085

Edit the Tomcat server configuration:

```bash
sudo vi /etc/tomcat/server.xml
```

Update the Connector port:
```xml
<Connector port="8085" protocol="org.apache.coyote.http11.Http11NioProtocol"
```
(Save and exit)

---

### 3️⃣ Start and enable Tomcat

```bash
sudo systemctl start tomcat
sudo systemctl enable tomcat
```

Verify service status:
```bash
sudo systemctl status tomcat
```

Confirm Tomcat is listening on port 8085:
```bash
ss -lntp | grep 8085
```

---

### 4️⃣ Copy application artifact from Jump Host

From Jump Host:
```bash
scp /tmp/ROOT.war tony@stapp03:/tmp/
```

---

### 5️⃣ Deploy the application

Move the WAR file to Tomcat webapps directory:

```bash
sudo mv /tmp/ROOT.war /usr/share/tomcat/webapps/
```

Set correct ownership:
```bash
sudo chown tomcat:tomcat /usr/share/tomcat/webapps/ROOT.war
```

---

### 6️⃣ Restart Tomcat to deploy application

```bash
sudo systemctl restart tomcat
```

(Optional) Monitor deployment logs:
```bash
sudo tail -f /var/log/tomcat/catalina.out
```

---

### 7️⃣ Verify application

```bash
curl http://stapp03:8085
```

---

## ✅ Result
- Tomcat installed and running on port 8085
- Java application successfully deployed as ROOT application
- Application accessible via base URL
- Task completed successfully

---

## 🧠 Key Takeaways
- Tomcat auto-deploys WAR files placed in `webapps`
- `ROOT.war` maps directly to `/`
- Port configuration is handled in `server.xml`
- Restarting the service is required after configuration changes

---

## 💼 Skills Demonstrated
- Java application deployment
- Apache Tomcat administration
- Linux service management
- Application server configuration

---

**Status:** ✅ Completed  
**Day 11 of #100DaysOfDevOps**
