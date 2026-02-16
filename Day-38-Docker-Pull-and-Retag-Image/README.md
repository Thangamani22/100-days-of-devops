# Day 38 – Pull and Re-tag Docker Image

## 📌 Objective
Pull a Docker image from a public registry and re-tag it for local use, following best practices for image management.

---

## 🧠 Scenario Overview
- Server: App Server 1 (Stratos DC)
- Image to pull: busybox:musl
- New tag to create: busybox:local
- Purpose: Prepare an internally tagged image for testing

---

## 🔑 Concept Learned: Docker Image Tags
Docker image tags are labels that reference a specific image ID.

Key points:
- Tags do not duplicate images
- Multiple tags can point to the same image
- Re-tagging is commonly used for internal or approved images

---

## ✅ Steps Performed

### 1️⃣ Pull the required image
```bash
sudo docker pull busybox:musl
```

---

### 2️⃣ Verify the image exists locally
```bash
sudo docker images
```

Confirmed that busybox:musl was available.

---

### 3️⃣ Re-tag the image
```bash
sudo docker tag busybox:musl busybox:local
```

This creates a new tag referencing the same image.

---

### 4️⃣ Verify both tags
```bash
sudo docker images | grep busybox
```

Expected output:
```
busybox   musl
busybox   local
```

Both tags point to the same IMAGE ID.

---

## 🧠 Key Learnings
- Docker tags are references, not copies
- Re-tagging does not consume additional disk space
- Tags help manage images across environments
- Local tags are useful for internal testing workflows

---

## 🏁 Outcome
✔️ Image pulled successfully  
✔️ Image re-tagged for local use  
✔️ Image ready for containerized testing  

---

## ✅ Status
Day 38 task completed successfully
