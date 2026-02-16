# Day 37 – Copy File to a Docker Container

## 📌 Objective
Securely copy an encrypted file from the Docker host into a running container without modifying the file contents.

---

## 🧠 Scenario Overview
- Server: Application Server 3
- Running container: ubuntu_latest
- Host file to copy: /tmp/nautilus.txt.gpg
- Destination inside container: /usr/src/
- Requirement: File must remain unchanged during transfer

---

## 🔑 Concept Learned: docker cp
docker cp is used to copy files between the Docker host and a container.

Key points:
- Works with running or stopped containers
- Copies files byte-for-byte (safe for encrypted files)
- Does not require rebuilding images or mounting volumes
- Ideal for one-time file transfers

---

## ✅ Steps Performed

### 1️⃣ Verify the container is running
```bash
sudo docker ps
```

Confirmed that the ubuntu_latest container is in a running state.

---

### 2️⃣ Copy the encrypted file into the container
```bash
sudo docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/usr/src/
```

- Source: Host filesystem
- Destination: Container filesystem
- No output indicates successful execution

---

### 3️⃣ Verify the file inside the container
```bash
sudo docker exec -it ubuntu_latest ls -l /usr/src/
```

Confirmed that nautilus.txt.gpg exists in the destination directory.

---

## 🧠 Key Learnings
- Containers have isolated filesystems from the host
- docker cp is the safest method for copying sensitive files
- Encrypted files remain unchanged during copy
- Volumes are better for long-term sharing, not one-time transfers

---

## 🏁 Outcome
✔️ Encrypted file copied successfully  
✔️ File integrity preserved  
✔️ No container restart or rebuild required  

---

## ✅ Status
Day 37 task completed successfully
