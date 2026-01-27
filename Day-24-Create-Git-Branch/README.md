
# Day 24 – Create a Feature Branch Safely in a Shared Git Repository

## Objective
Create a new feature branch from the `master` branch in an existing Git repository **without modifying any code**, while correctly handling Git’s **dubious ownership** security check in a shared DevOps-managed environment.

---

## Repository Details
- Repository path: `/usr/src/kodekloudrepos/cluster`
- Base branch: `master`
- New branch: `xfusioncorp_cluster`
- Environment: Shared repository on Storage Server

---

## Why This Task Matters

This task teaches two important real-world Git concepts:

1. **Why teams use branches** to isolate new development
2. **How Git enforces security** in shared repositories using ownership checks

Both are everyday realities for DevOps engineers.

---

## Concept 1: Why Create a Separate Branch?

In production workflows:
- `master` (or `main`) represents **stable code**
- New features should never be developed directly on it
- A separate branch allows:
  - Safe experimentation
  - Parallel development
  - Clean review and merge later

Creating a branch does **not** copy code — it simply creates a new pointer to the same commit.

---

## Concept 2: Dubious Ownership in Git (Important)

When running:
```bash
git status
```

You may see:
```text
fatal: detected dubious ownership in repository
```

### Why this happens
- The repository directory is owned by a different user (e.g., `root`)
- The current user (e.g., `natasha`) is running Git commands
- Git blocks access to prevent potential security risks

This is a **Git security feature** introduced in newer versions.

---

## Correct Way to Handle Dubious Ownership

❌ Do NOT change directory ownership  
❌ Do NOT modify permissions  

✅ Use Git’s built-in trust mechanism:

```bash
git config --global --add safe.directory /usr/src/kodekloudrepos/cluster
```

### What this does
- Marks the repository as trusted for the current user
- Does not alter OS-level permissions
- Is the recommended solution for shared environments

---

## Step-by-Step Execution

### Step 1: Navigate to the Repository
```bash
cd /usr/src/kodekloudrepos/cluster
```

---

### Step 2: Mark Repository as Safe
```bash
git config --global --add safe.directory /usr/src/kodekloudrepos/cluster
```

Verify:
```bash
git status
```

---

### Step 3: Ensure You Are on `master`
```bash
git branch
```

If required:
```bash
git checkout master
```

---

### Step 4: Create the New Branch
```bash
git branch xfusioncorp_cluster
```

**Purpose:**
- Creates a new branch pointer
- No code changes are made
- Satisfies task requirements exactly

---

### Step 5: Verify Branch Creation
```bash
git branch
```

Expected output:
```text
* master
  xfusioncorp_cluster
```

---

## What NOT to Do

❌ Do not modify files  
❌ Do not commit changes  
❌ Do not switch branches unnecessarily  
❌ Do not change ownership with `chown`

---

## How This Fits the Git Learning Path

- **Day 21:** Central repository creation  
- **Day 22:** Developer cloning workflow  
- **Day 23:** Forking for safe contribution  
- **Day 24:** Branching for feature isolation  

Together, these represent real-world Git collaboration fundamentals.

---

## Interview-Ready Explanation

> “I created a feature branch from master without modifying code and handled Git’s dubious ownership check using the `safe.directory` configuration, which is the recommended approach in shared DevOps-managed repositories.”

---

## Status
✅ **Day 24 task completed successfully**
