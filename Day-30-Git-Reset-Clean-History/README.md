# Day 30 – Git Reset (Cleaning Commit History)

## 📌 Objective
Clean a Git repository by rewriting commit history and work tree, keeping only the required commits and removing all unwanted test commits.

---

## 🧠 Scenario Overview
- Repository: /usr/src/kodekloudrepos/cluster
- This was a test repository with extra commits
- Requirement was to:
  - Remove unwanted commits
  - Clean the working tree
  - Point HEAD and branch back to a specific commit

---

## 🎯 Final Requirement
After cleanup, the repository should contain only two commits:

1. initial commit
2. add data.txt file (HEAD should point here)

---

## 🔑 Concept Used: git reset --hard
git reset --hard is used to:
- Move HEAD to a specific commit
- Move the branch pointer to the same commit
- Reset the working directory to match that commit
- Permanently remove commits that came after it

This operation rewrites Git history, so it must be followed by a force push.

---

## ✅ Steps Performed

### 1️⃣ Navigate to the repository
```bash
cd /usr/src/kodekloudrepos/cluster
```

---

### 2️⃣ Identify the target commit
```bash
git log --oneline
```

Located the commit with message:
add data.txt file

Copied its commit SHA.

---

### 3️⃣ Reset repository to the target commit
```bash
git reset --hard <commit-sha>
```

This:
- Moved HEAD to add data.txt file
- Removed all commits after it
- Cleaned the working tree

---

### 4️⃣ Verify commit history
```bash
git log --oneline
```

Confirmed only:
add data.txt file  
initial commit

---

### 5️⃣ Push rewritten history
```bash
git push origin HEAD --force
```

---

## 🧠 Key Learnings
- git reset --hard rewrites commit history
- Useful for cleaning test or accidental commits
- Removes commits permanently from local history
- Force push is required after history rewrite
- Should be used carefully in shared repositories

---

## 🏁 Outcome
- Repository cleaned successfully
- Commit history reduced to required state
- HEAD and branch correctly pointed

---

## ✅ Status
Day 30 task completed successfully
