
# Day 25 – Git Merge Branches (End-to-End Workflow)

## Objective
Implement a complete **Git feature development workflow** by creating a new branch, adding and committing changes, merging them back into `master`, and pushing all updates to the remote repository.

This task represents a **milestone** in understanding real-world Git collaboration used by DevOps and development teams.

---

## Repository Details
- Central repository: `/opt/news.git`
- Working copy location: `/usr/src/kodekloudrepos/news`
- Base branch: `master`
- Feature branch: `nautilus`
- File to be added: `/tmp/index.html`
- Server: Storage Server (Stratos DC)

---

## Why This Task Matters

This task brings together multiple Git concepts learned previously:

- Central repositories (Day 21)
- Cloning repositories (Day 22)
- Forking for safe collaboration (Day 23)
- Branching strategy (Day 24)
- **Merging and publishing changes (Day 25)**

It reflects how changes safely move from development into stable branches in production environments.

---

## Concept Overview

### Why Use Feature Branches?
- `master` represents stable, production-ready code
- Feature branches isolate changes
- Reduces risk and improves collaboration

### Why Merge?
- Integrates completed work back into the main codebase
- Preserves history and traceability
- Allows controlled delivery of changes

---

## Step-by-Step Execution (With Purpose)

### Step 1: Navigate to the Repository
```bash
cd /usr/src/kodekloudrepos/news
```

Verify repository status:
```bash
git status
```

---

### Step 2: Ensure You Are on `master`
```bash
git branch
```

If required:
```bash
git checkout master
```

**Purpose:**  
Always branch from a clean and stable base.

---

### Step 3: Create and Switch to Feature Branch
```bash
git checkout -b nautilus
```

**Purpose:**
- Creates a new branch for isolated development
- Switches context to the feature branch

---

### Step 4: Copy the File into the Repository
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
Explicitly selects files to be included in the commit.

---

### Step 6: Commit the Change
```bash
git commit -m "Add index.html file"
```

**Purpose:**
- Creates a permanent record of the change
- Enables merging into other branches

---

### Step 7: Switch Back to `master`
```bash
git checkout master
```

**Purpose:**  
Merges are performed from the target branch.

---

### Step 8: Merge Feature Branch into `master`
```bash
git merge nautilus
```

**What Happens Here:**
- Changes from `nautilus` are applied to `master`
- Since no conflicts exist, Git performs a fast-forward merge

---

### Step 9: Push Changes to Origin

Push `master`:
```bash
git push origin master
```

Push `nautilus`:
```bash
git push origin nautilus
```

**Purpose:**
- Publishes changes for the team
- Preserves both stable and feature branch history

---

## Verification (Optional but Recommended)
```bash
git log --oneline --graph --all
git branch
```

---

## What NOT to Do
❌ Do not commit directly on `master`  
❌ Do not skip pushing the feature branch  
❌ Do not delete the feature branch (not requested)  

---

## Key Learnings
- Feature branches isolate changes
- Commits are required before merging
- Merges integrate completed work safely
- Pushing updates shares work with the team
- This workflow mirrors real CI/CD practices

---

## Interview-Ready Explanation

> “I created a feature branch from master, added and committed changes in isolation, merged them back into master, and pushed both branches to the remote repository to maintain a clean and traceable Git workflow.”

---

## Milestone Achieved
✅ **Days 21–25 Git collaboration workflow completed**

This milestone demonstrates practical understanding of Git usage in real DevOps environments.
