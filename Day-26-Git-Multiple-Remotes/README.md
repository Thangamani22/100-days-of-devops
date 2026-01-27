
# Day 26 – Working with Multiple Git Remotes

## Objective
Update an existing Git repository to work with **multiple remotes**, commit new changes locally, and push those changes to a **newly added remote repository**.

This task introduces a key real-world Git concept: **one local repository can push to multiple remote repositories**.

---

## Repository Details
- Working repository: `/usr/src/kodekloudrepos/apps`
- Original remote repository: `/opt/apps.git`
- New remote name: `dev_apps`
- New remote path: `/opt/xfusioncorp_apps.git`
- Branch used: `master`
- File to add: `/tmp/index.html`
- Server: Storage Server (Stratos DC)

---

## Why This Task Matters

In real DevOps environments:
- Code is often pushed to **multiple repositories**
- Different remotes may represent:
  - Different environments (dev, staging, prod)
  - Repository migrations
  - Backup or mirror repositories

This task teaches how to safely manage and push code to **more than one Git remote**.

---

## Concept Overview: Git Remotes (Beginner Friendly)

A **Git remote** is a named reference to another Git repository.

Example:
```bash
git remote -v
```

Output:
```text
origin    /opt/apps.git (fetch)
origin    /opt/apps.git (push)
```

Here:
- `origin` is just a **name**
- `/opt/apps.git` is the actual repository location

Git allows adding **multiple remotes**:
```text
origin     → old repository
dev_apps   → new repository
```

---

## Step-by-Step Execution (With Purpose)

### Step 1: Navigate to the Repository
```bash
cd /usr/src/kodekloudrepos/apps
```

Verify repository:
```bash
git status
```

---

### Step 2: View Existing Remotes
```bash
git remote -v
```

**Purpose:**
- Understand current remote configuration
- Avoid accidental overwrites

---

### Step 3: Add the New Remote
```bash
git remote add dev_apps /opt/xfusioncorp_apps.git
```

**Purpose:**
- Registers a new remote named `dev_apps`
- Does not push any code yet

Verify:
```bash
git remote -v
```

Expected:
```text
dev_apps   /opt/xfusioncorp_apps.git (fetch)
dev_apps   /opt/xfusioncorp_apps.git (push)
```

---

### Step 4: Copy File into the Repository
```bash
cp /tmp/index.html .
```

Verify:
```bash
ls
```

---

### Step 5: Stage the File
```bash
git add index.html
```

**Purpose:**
- Selects the file to be included in the commit

---

### Step 6: Commit Changes to Master Branch
Verify branch:
```bash
git branch
```

Ensure:
```text
* master
```

Commit:
```bash
git commit -m "Add index.html file"
```

---

### Step 7: Push Master Branch to New Remote
```bash
git push dev_apps master
```

**Purpose:**
- Pushes the local `master` branch to the `dev_apps` remote
- Shares changes with the new repository

---

## Verification (Optional)
```bash
git branch -r
```

Expected to see:
```text
dev_apps/master
origin/master
```

---

## Key Learnings
- A Git repository can have multiple remotes
- Remotes are named references, not special keywords
- Commits must exist before pushing
- Branches are pushed explicitly to specific remotes
- This workflow is common in real DevOps setups

---

## Interview-Ready Explanation

> “I added a new Git remote, committed changes locally on master, and explicitly pushed the branch to the new remote repository.”

---

## Status
✅ **Day 26 task completed successfully**
