# Day 36 – Running a Docker Container (Nginx)

## 📌 Objective
Deploy and run a Docker container using the **nginx:alpine** image on **Application Server 3**, ensuring the container is created with the required name and is in a running state.

---

## 🧠 Scenario Overview
- Team: Nautilus DevOps
- Server: Application Server 3
- Requirement:
  - Run an Nginx container
  - Container name: `nginx_3`
  - Image: `nginx:alpine`
  - Container must be in **running** state

---

## 🔑 Concept Recap
- **Docker Image**: A read-only template used to create containers
- **Docker Container**: A running instance of an image
- **nginx:alpine**: Lightweight Nginx image based on Alpine Linux, commonly used in production environments

---

## ✅ Steps Performed

### 1️⃣ Verify Docker service is running
```bash
sudo systemctl status docker
```

Confirmed that Docker daemon (`dockerd`) is active.

---

### 2️⃣ Run the Nginx container
```bash
sudo docker run -d --name nginx_3 nginx:alpine
```

Explanation:
- `docker run` → Creates and starts a container
- `-d` → Runs container in detached mode
- `--name nginx_3` → Assigns the container name
- `nginx:alpine` → Specifies the image to use

Docker automatically pulled the image since it was not present locally.

---

### 3️⃣ Verify container status
```bash
sudo docker ps
```

Expected output includes:
```
nginx_3   nginx:alpine   Up
```

This confirms the container is running successfully.

---

### 4️⃣ (Optional) Check container logs
```bash
sudo docker logs nginx_3
```

Nginx startup logs confirm successful container initialization.

---

## 🧠 Key Learnings
- `docker run` pulls an image if not available locally
- Containers run as background services using detached mode
- Lightweight images like `nginx:alpine` are efficient and fast
- Docker daemon must be running for containers to start

---

## 🏁 Outcome
✔️ Nginx container deployed successfully  
✔️ Container named `nginx_3` is running  
✔️ Application Server 3 is actively running a containerized service  

---

## ✅ Status
**Day 36 task completed successfully** 🚀
