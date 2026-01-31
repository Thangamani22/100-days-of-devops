# Day 31 – Git Stash (Restore Stashed Changes)

## 📌 Objective
Understand and use Git stash to restore previously stashed in-progress changes, then commit and push them to the remote repository.

---

## 🧠 Scenario Overview
- Repository location: /usr/src/kodekloudrepos/beta
- A developer had stashed some unfinished changes
- Requirement was to:
  - Identify available stashes
  - Restore a specific stash (stash@{1})
  - Commit the restored changes
  - Push them to the remote repository

---

## 🔑 Concept Used: Git Stash
git stash is used to temporarily save uncommitted changes so that work can be paused without creating a commit.

Key points:
- Stashes are stored in a stack
- stash@{0} is the most recent stash
- Older stashes are referenced as stash@{1}, stash@{2}, etc.
- Stashes are local to the repository

---

## ✅ Steps Performed

### 1️⃣ Navigate to the repository
```bash
cd /usr/src/kodekloudrepos/beta
```

---

### 2️⃣ List available stashes
```bash
git stash list
```

Confirmed that stash@{1} was present.

---

### 3️⃣ Restore the required stash
```bash
git stash apply stash@{1}
```

This restored the stashed changes without removing them from the stash list.

---

### 4️⃣ Verify restored changes
```bash
git status
```

Confirmed that files were modified and ready to be committed.

---

### 5️⃣ Commit the restored changes
```bash
git add .
git commit -m "Restore stashed changes"
```

---

### 6️⃣ Push changes to remote
```bash
git push origin master
```

---

## 🧠 Key Learnings
- Git stash is useful for handling in-progress work
- Specific stashes can be restored using their identifier
- git stash apply is safer than git stash pop
- Stashes allow clean context switching without losing work

---

## 🏁 Outcome
- Successfully restored stashed changes
- Changes committed and pushed to remote
- In-progress work safely recovered

---

## ✅ Status
Day 31 task completed successfully
