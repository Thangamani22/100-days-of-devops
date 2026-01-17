
# Day 21 – Create a Bare Git Repository on Storage Server

## Objective
Set up a **central Git repository** on the Storage Server for the Nautilus development team.  
This repository will act as a shared location where developers can **push and pull code**, similar to how GitHub or GitLab works internally.

---

## Why This Task Matters

In real-world DevOps environments:
- Teams use a **central Git server** to collaborate
- That server hosts **bare repositories**
- Developers never edit code directly on the Git server

This task introduces the concept of **bare Git repositories**, which are essential for team-based development.

---

## What is a Bare Git Repository? (Beginner Explanation)

A **normal Git repository** (on a developer machine) contains:
- Source code files
- A `.git` directory with metadata

A **bare Git repository** contains:
- Only Git metadata
- No working directory
- No source files

Example structure:
```text
news.git/
├── HEAD
├── objects/
├── refs/
├── hooks/
├── config
```

### Why bare repositories?
- They are meant to be **pushed to**, not edited
- Prevent accidental file changes on the server
- Ideal for central/shared repositories

---

## Task Requirements

1. Install Git on the Storage Server using `yum`
2. Create a bare repository named **`/opt/news.git`**

---

## Step-by-Step Execution (With Purpose)

### Step 1: Login to the Storage Server
Ensure all commands are executed on the **Storage Server**.

You can verify using:
```bash
hostname
```

---

### Step 2: Install Git Using yum
```bash
sudo yum install -y git
```

**Purpose:**
- Installs Git and required dependencies
- Ensures the system can create and manage repositories

Verify installation:
```bash
git --version
```

---

### Step 3: Navigate to `/opt` Directory
```bash
cd /opt
```

**Purpose:**
- `/opt` is commonly used for optional or application-related software and data
- Suitable location for hosting internal repositories

---

### Step 4: Create the Bare Repository
```bash
sudo git init --bare news.git
```

**Command Breakdown:**
- `git init` → Initializes a Git repository
- `--bare` → Creates a repository without a working tree
- `news.git` → Exact repository name required by the task

---

### Step 5: Verify the Repository
```bash
ls /opt/news.git
```

Expected output:
```text
HEAD
objects
refs
hooks
config
```

This confirms the repository is **bare** and ready for use.

---

## How This Repository Will Be Used (Concept)

Developers can now:
- Clone the repository:
  ```bash
  git clone user@storage-server:/opt/news.git
  ```
- Push code to it:
  ```bash
  git push origin main
  ```

The Storage Server acts as the **single source of truth** for the project.

---

## Common Mistake to Avoid

❌ Creating a normal repository:
```bash
git init news
```

This creates a working directory and is **not suitable** for a central Git server.

---

## Key Learnings
- Bare repositories are designed for collaboration
- Central Git servers host bare repositories
- `git init --bare` is used for shared repositories
- No working directory means safer team workflows

---

## Status
✅ **Day 21 task completed successfully**
