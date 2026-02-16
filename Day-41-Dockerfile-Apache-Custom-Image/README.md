# Day 41 – Dockerfile Basics: Build Custom Apache Image

## 📌 Objective
Create a **custom Docker image** using a Dockerfile to install and configure Apache on a non-default port, following reproducible and minimal image design principles.

---

## 🧠 Scenario Overview
- Server: App Server 3 (Stratos DC)
- Requirement:
  - Create `/opt/docker/Dockerfile` (capital D)
  - Base image: `ubuntu:24.04`
  - Install `apache2`
  - Configure Apache to listen on **port 5002**
  - Do not modify other Apache settings (document root, vhosts, etc.)

---

## 🔑 Concept Learned: Dockerfile Structure
A Dockerfile is a **declarative recipe** that defines how an image should be built.

Typical structure:
1. Base image
2. Package installation
3. Configuration changes
4. Port exposure
5. Foreground process to keep container running

Each instruction creates a **new image layer**.

---

## ✅ Dockerfile Used

```dockerfile
FROM ubuntu:24.04

RUN apt update &&     apt install -y apache2 &&     sed -i 's/Listen 80/Listen 5002/' /etc/apache2/ports.conf

EXPOSE 5002

CMD ["apachectl", "-D", "FOREGROUND"]
```

---

## 🧠 Why This Dockerfile Is Minimal
- No unnecessary environment variables
- No image-size optimizations (not required for task)
- Only required configuration change applied
- Apache runs in foreground (required for Docker containers)

---

## ⚙️ Steps Performed

### 1️⃣ Navigate to Dockerfile location
```bash
cd /opt/docker
```

---

### 2️⃣ Build the Docker image
```bash
docker build -t apache-5002 .
```

- `-t apache-5002` assigns a readable image name
- `.` specifies the current directory as the build context

---

## 🧠 Key Learnings
- Dockerfiles describe **final image state**, not interactive steps
- Services must run in the foreground inside containers
- `EXPOSE` documents intended runtime ports
- Minimal Dockerfiles improve clarity and maintainability
- Dockerfile-based builds are preferred over live container changes for long-term setups

---

## 🏁 Outcome
✔️ Dockerfile created successfully  
✔️ Custom Apache image built using Ubuntu 24.04  
✔️ Apache configured to listen on port 5002  
✔️ Image ready for container deployment  

---

## ✅ Status
**Day 41 task completed successfully** 🚀
