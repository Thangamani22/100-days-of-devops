# Day 28 – Git Cherry-Pick (Selective Commit Merge)

## 📌 Objective
Learn how to merge **only a specific commit** from one branch into another without merging the entire branch.

---

## 🧠 Scenario
- Repository contains two branches: `master` and `feature`
- `feature` branch work is still in progress
- One commit from `feature` is production-ready
- Commit message to be merged: **Update info.txt**

---

## 🔑 Concept Learned: `git cherry-pick`
`git cherry-pick` allows you to apply **a single commit** from any branch onto the **current branch**, using the commit SHA.

- Git identifies commits by **commit hash (SHA)**, not by message
- Commit messages help humans locate commits
- SHA is what Git actually uses

---

## ✅ Steps Followed

### 1. Navigate to the repository
```bash
cd /usr/src/kodekloudrepos/blog
```

### 2. Switch to master branch
```bash
git checkout master
```

### 3. Find the required commit SHA from feature branch
```bash
git log feature --oneline
```

Look for:
```
Update info.txt
```

Copy the associated SHA.

### 4. Cherry-pick the commit into master
```bash
git cherry-pick <commit-sha>
```

### 5. Push changes to remote
```bash
git push origin master
```

---

## 🧠 Key Takeaways
- `git cherry-pick` applies commits to the **current branch**
- Useful when only part of a feature branch is ready
- Avoids unnecessary or incomplete changes entering `master`
- Commonly used in hotfixes and selective production releases

---

## 🏁 Outcome
Successfully merged a single required commit from `feature` into `master` without affecting ongoing work.

✔️ Task completed  
✔️ New Git concept learned  
✔️ Real-world DevOps use case practiced
