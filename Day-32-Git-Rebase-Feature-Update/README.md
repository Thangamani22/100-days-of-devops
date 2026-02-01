# Day 32 – Git Rebase (Keeping Feature Branch Up to Date)

## 📌 Objective
Update an in-progress feature branch with the latest changes from the master branch without creating a merge commit, while preserving all feature work and maintaining a clean, linear commit history.

---

## 🧠 Scenario Overview
- Repository: /usr/src/kodekloudrepos/media
- A developer is working on a feature branch
- New commits were added to master
- Requirement was to:
  - Bring latest master changes into feature
  - Avoid creating a merge commit
  - Preserve all feature branch work
  - Push the updated feature branch to remote

---

## 🔑 Concept Used: Git Rebase
git rebase replays feature branch commits on top of the latest master branch.

Why rebase here:
- Keeps commit history clean and linear
- Avoids unnecessary merge commits
- Makes feature branch appear as if it started from latest master

---

## 🧩 Visual Representation

Before Rebase:
master:  A --- B --- C  
feature:       D --- E  

After Rebase:
master:  A --- B --- C  
feature:              D' --- E'  

---

## ✅ Steps Performed

### 1️⃣ Navigate to the repository
```bash
cd /usr/src/kodekloudrepos/media
```

---

### 2️⃣ Switch to feature branch
```bash
git checkout feature
```

---

### 3️⃣ Rebase feature branch onto master
```bash
git rebase master
```

If conflicts occurred:
```bash
# resolve conflicts
git add .
git rebase --continue
```

---

### 4️⃣ Verify commit history
```bash
git log --oneline --graph
```

Confirmed clean, linear history with no merge commit.

---

### 5️⃣ Push rebased feature branch
Since rebase rewrites history, a force push is required.

```bash
git push -u origin feature --force-with-lease
```

This also sets the upstream branch for future pushes.

---

## 🧠 Key Learnings
- git rebase is ideal for updating local feature branches
- Rebase avoids merge commits and keeps history clean
- Rewriting history requires force push
- Upstream branches are needed for simple git push
- Never rebase shared or protected branches

---

## 🏁 Outcome
- Feature branch updated with latest master changes
- No merge commit created
- Clean and readable Git history
- Changes pushed successfully

---

## ✅ Status
Day 32 task completed successfully
