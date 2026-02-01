# Day 33 – Git Merge Conflict Resolution (Real-World Scenario)

## 📌 Objective
Understand and resolve a Git merge conflict caused by multiple developers modifying the same files, ensuring correctness of content before merging and pushing changes to the remote repository.

---

## 🧠 Scenario Overview
- Repository: story-blog
- Two developers (Sarah and Max) worked on story files
- Both pushed changes affecting:
  - story-index.txt
  - Story content files
- Max faced issues while pushing due to conflicts with remote changes

---

## 🔍 Root Cause of the Conflict
- Sarah and Max modified overlapping sections of story-index.txt
- Git could not automatically decide which version to keep
- As a result, Git paused the merge and marked the file with conflict markers

---

## 🔑 Understanding Conflict Markers

```text
<<<<<<< HEAD
Local changes (Max)
=======
Remote changes (Sarah)
>>>>>>> commit-hash
```

- HEAD → Local branch version
- Commit hash → Remote branch version
- Developer must manually decide the correct final content

---

## ✅ Requirements to Satisfy
1. story-index.txt must list all 4 stories
2. Typo correction:
   - “Mooose” → Mouse
3. Clean file with no conflict markers
4. Merge completed and pushed successfully

---

## 🛠️ Steps Performed

### 1️⃣ Fetch latest remote changes
```bash
git fetch origin
```

Safely inspected remote updates without modifying local files.

---

### 2️⃣ Pull changes to surface conflicts
```bash
git pull origin master
```

This triggered merge conflicts due to overlapping changes.

---

### 3️⃣ Resolve conflicts manually
- Edited story-index.txt
- Removed conflict markers
- Ensured correct and complete story list

Final content:
```text
1. The Lion and the Mouse
2. The Frogs and the Ox
3. The Fox and the Grapes
4. The Donkey and the Dog
```

---

### 4️⃣ Mark conflicts as resolved
```bash
git add story-index.txt
```

---

### 5️⃣ Complete the merge
```bash
git commit
```

Git created a merge commit to safely combine both histories.

---

### 6️⃣ Push changes to remote
```bash
git push origin master
```

---

## 🧠 Key Learnings
- Merge conflicts occur when Git cannot auto-resolve overlapping changes
- Conflict markers clearly show local vs remote versions
- Fetch first to inspect changes safely
- Merge (not rebase) is the correct approach for shared branches
- Manual conflict resolution is a critical real-world Git skill

---

## 🏁 Outcome
- Merge conflict resolved successfully
- All requirements satisfied
- Clean and correct content pushed to remote

---

## ✅ Status
Day 33 task completed successfully
