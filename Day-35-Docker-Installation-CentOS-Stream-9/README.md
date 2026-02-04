# Day 35 – Docker Installation (docker-ce & docker compose) on CentOS Stream 9

## 📌 Objective
Install **Docker Community Edition (docker-ce)** and **Docker Compose** on **App Server 3** running **CentOS Stream 9**, then start and verify the Docker service.

---

## 🧠 Environment Details
- OS: CentOS Stream 9 (EL9 family)
- Purpose: Prepare the server for containerized application testing
- Packages installed:
  - docker-ce
  - docker-ce-cli
  - containerd.io
  - docker-buildx-plugin
  - docker-compose-plugin

---

## 🔑 Concepts Learned
- **docker-ce** is the open-source Docker engine used to run containers.
- Docker runs as a **daemon (`dockerd`)** managed by systemd.
- **Docker Compose v2** is provided as a plugin (`docker compose`) rather than a separate binary.
- CentOS Stream 9 does not include Docker in default repositories; Docker’s official repo is required.

---

## ✅ Steps Performed

### 1️⃣ Update the system
```bash
sudo dnf -y update
```

---

### 2️⃣ Install required dependencies
```bash
sudo dnf install -y yum-utils device-mapper-persistent-data lvm2
```

---

### 3️⃣ Add Docker CE repository
```bash
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

---

### 4️⃣ Install Docker CE and Docker Compose plugin
```bash
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

---

### 5️⃣ Start Docker service
```bash
sudo systemctl start docker
```

---

### 6️⃣ Enable Docker on boot
```bash
sudo systemctl enable docker
```

---

### 7️⃣ Verify Docker service status
```bash
sudo systemctl status docker
```

Expected state:
```
Active: active (running)
```

---

### 8️⃣ Verify Docker installation
```bash
docker version
docker ps
```

If permission is denied:
```bash
sudo docker ps
```

---

### 9️⃣ Verify Docker Compose
```bash
docker compose version
```

---

## 🧠 Key Learnings
- Docker must be installed from the official Docker repository on CentOS 9.
- The Docker daemon must be running for containers to work.
- Docker Compose v2 is integrated into the Docker CLI.
- Enabling Docker on boot ensures containers can run after a reboot.

---

## 🏁 Outcome
✔️ Docker Community Edition installed successfully  
✔️ Docker Compose plugin installed  
✔️ Docker service started and enabled  
✔️ Server is ready for containerized workloads  

---

## ✅ Status
**Day 35 task completed successfully** 🚀
