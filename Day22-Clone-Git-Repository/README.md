
# Day 22 – Clone a Central Git Repository (Developer Workflow)

## Objective
Clone an existing **central Git repository** from the Storage Server into a working directory, following a **developer-style workflow** and adhering strictly to access and permission constraints.

This task demonstrates how application developers consume a repository that was previously created by the DevOps team.

---

## Task Summary
- Repository source: `/opt/media.git`
- Destination directory: `/usr/src/kodekloudrepos`
- User to perform task: `natasha`(standard user)
- Restrictions:
  - ❌ No permission changes
  - ❌ No repository modifications
  - ❌ No unauthorized directory changes

---

## Concept Overview

### Central (Bare) Repository
- Located at: `/opt/media.git`
- Bare repository (no working tree)
- Used as a **source of truth**
- Created and managed by DevOps

### Cloned (Working) Repository
- Created under: `/usr/src/kodekloudrepos/media`
- Contains a working directory
- Used by developers to write and test code

This mirrors real-world usage:
```
GitHub / GitLab repo → Developer machine
```

---

## Why This Task Matters

In real teams:
- DevOps teams **create and manage** repositories
- Developers **clone** repositories to start work
- Developers operate as **non-root users**
- Infrastructure integrity is preserved by avoiding unnecessary changes

This task reinforces **role separation and discipline**.

---

## Step-by-Step Execution (With Purpose)

### Step 1: Switch to the `natasha` User
```bash
su - natasha
```

**Purpose:**
- Ensures the task is performed as a standard user
- Reflects real developer access patterns

Verify:
```bash
whoami
```

Expected output:
```text
natasha
```

---

### Step 2: Verify Destination Directory
```bash
ls -ld /usr/src/kodekloudrepos
```

**Purpose:**
- Confirms the directory exists
- No ownership or permission changes are made

---

### Step 3: Navigate to Destination Directory
```bash
cd /usr/src/kodekloudrepos
```

---

### Step 4: Clone the Repository
```bash
git clone /opt/media.git
```

**What This Does:**
- Clones the bare repository into a working directory
- Creates a new folder named `media`
- Preserves full commit history
- Sets `/opt/media.git` as the remote `origin`

---

### Step 5: Verify the Clone
```bash
ls
```

Expected output:
```text
media
```

Check repository status:
```bash
cd media
git status
```

Expected output:
```text
On branch master (or main)
nothing to commit, working tree clean
```

---

## What NOT to Do (Important)

❌ Do not run:
```bash
git init
```

❌ Do not change permissions:
```bash
chmod
chown
```

❌ Do not modify or commit files

This task is **clone-only**.

---

## How This Fits the Real Development Workflow

1. DevOps creates a central bare repository
2. Developers clone the repository
3. Developers create branches and add code
4. Changes are pushed back to the central repo

This task focuses on **Step 2**.

---

## Key Learnings
- Bare repositories act as shared sources
- Cloned repositories are developer workspaces
- Developers use non-root accounts
- Respecting boundaries prevents infra issues
- `git clone` bridges DevOps and development

---

## Status
✅ **Day 22 task completed successfully**
