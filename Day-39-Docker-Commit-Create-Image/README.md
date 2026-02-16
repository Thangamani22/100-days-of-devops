# Day 39 – Create Docker Image from a Running Container

## 📌 Objective
Create a new Docker image from a running container to preserve its current state for backup and testing purposes.

---

## 🧠 Scenario Overview
- Server: Application Server 1
- Running container: `ubuntu_latest`
- Requirement: Create a new image from the container
- New image name: `media:devops`

---

## 🔑 Concept Learned: docker commit
`docker commit` is used to create a Docker image from the current state of a container.

Key points:
- Captures the container’s writable layer
- Saves file system changes into a new image
- Useful for quick backups and debugging
- Not recommended for production-grade builds (Dockerfile preferred)

---

## ✅ Steps Performed

### 1️⃣ Verify the container is running
```bash
sudo docker ps
```

Confirmed that the `ubuntu_latest` container is active.

---

### 2️⃣ Create an image from the container
```bash
sudo docker commit ubuntu_latest media:devops
```

This command creates a new image using the container’s current state.

---

### 3️⃣ Verify the new image
```bash
sudo docker images | grep media
```

Expected output:
```
media   devops
```

---

## 🧠 What Was Captured in the Image
- File system changes inside the container
- Installed packages and configuration files
- Files copied using `docker cp`

Not captured:
- Running processes
- Temporary runtime-only state

---

## 🧠 Key Learnings
- docker commit snapshots a container into an image
- The new image includes all filesystem changes
- Dockerfile provides better reproducibility for production
- docker commit is useful for experiments and backups

---

## 🏁 Outcome
✔️ Container state successfully saved as an image  
✔️ New image `media:devops` created  
✔️ Image ready for reuse or further testing  

---

## ✅ Status
**Day 39 task completed successfully** 🚀
