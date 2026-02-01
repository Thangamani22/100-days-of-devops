# Day 34 – Git Hooks (Automatic Release Tagging)

## 📌 Objective
Learn and implement a Git server-side hook to automatically create a release tag whenever changes are pushed to the master branch.

---

## 🧠 Scenario Overview
- Repository: /opt/apps.git (bare repository)
- Clone location: /usr/src/kodekloudrepos/apps
- User performing the task: natasha
- Requirement:
  - Merge feature branch into master
  - Create a post-update hook
  - Automatically generate a release tag in the format:
    release-YYYY-MM-DD
  - Verify the hook by triggering it at least once

---

## 🔑 Concept Learned: Git Hooks
Git hooks are scripts that run automatically when specific Git events occur.

Key points:
- Hooks live inside .git/hooks/
- They are not version-controlled
- Server-side hooks run on the receiving repository
- post-update runs after refs are updated during a push

---

## 🧩 Important Concept Clarification
- Hooks placed in a local clone do NOT run on push
- Server-side hooks must be created in the bare repository
- Tags created on the remote must be fetched to appear locally

---

## ✅ Steps Performed

### 1️⃣ Switch to natasha user
```bash
su - natasha
```

---

### 2️⃣ Navigate to the cloned repository
```bash
cd /usr/src/kodekloudrepos/apps
```

---

### 3️⃣ Merge feature branch into master
```bash
git checkout master
git merge feature
```

---

### 4️⃣ Create post-update hook in bare repository
```bash
cd /opt/apps.git/hooks
vi post-update
```

Hook script:
```bash
#!/bin/bash

ref="$1"

if [ "$ref" = "refs/heads/master" ]; then
    DATE=$(date +%Y-%m-%d)
    TAG="release-$DATE"
    git tag "$TAG"
fi
```

---

### 5️⃣ Make the hook executable
```bash
chmod +x post-update
```

---

### 6️⃣ Push changes to trigger the hook
```bash
cd /usr/src/kodekloudrepos/apps
git push origin master
```

---

### 7️⃣ Verify release tag
```bash
git fetch --tags
git tag
```

Expected output:
release-YYYY-MM-DD

---

## 🧠 Key Learnings
- Server-side hooks must be placed in the bare repository
- post-update is ideal for post-push automation
- Tags created remotely require git fetch --tags
- Git hooks enable lightweight automation without CI tools

---

## 🏁 Outcome
- Feature branch merged successfully
- post-update hook executed on push
- Release tag created automatically
- Concept of server-side hooks clearly understood

---

## ✅ Status
Day 34 task completed successfully
