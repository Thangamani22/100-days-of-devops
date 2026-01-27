
# Day 23 – Forking a Git Repository Using Gitea

## Objective
Enable a new developer to begin contributing to an existing project by **forking a repository** using the Gitea web interface.  
This task demonstrates how teams safely collaborate on shared codebases without giving direct write access.

---

## Task Summary
- Git platform: **Gitea**
- Original repository: `sarah/story-blog`
- New developer: `jon`
- Action performed: **Fork repository under jon’s account**
- Method: **Web UI (Gitea)**

---

## Concept Overview

### What is Forking in Git?

A **fork** is a server-side copy of a repository created under a different user’s account.

Example:
```
Original repo: sarah/story-blog
Forked repo:   jon/story-blog
```

Key characteristics:
- Fork is **independent** of the original repository
- The new owner has **full control** over their fork
- Original repository remains unchanged

---

## Why Forking Is Important

Forking enables:
- Safe experimentation by new developers
- Contribution without direct write access
- Clean separation of ownership and responsibility
- Code review workflows through pull requests

This model is widely used in:
- Open-source projects
- Enterprise GitHub / GitLab / Gitea setups

---

## How This Fits with Previous Days

- **Day 21:** Created a central Git repository  
- **Day 22:** Cloned a repository as a developer  
- **Day 23:** Forked a repository to enable safe contribution  

Together, they form a real-world collaboration flow:
```
Central Repo → Fork → Clone → Develop → Pull Request
```

---

## Step-by-Step Execution (UI-Based)

### Step 1: Access Gitea
- Click the **Gitea UI** button from the top bar
- This opens the Gitea web interface

---

### Step 2: Login as jon
- **Username:** `jon`
- **Password:** `Jon_pass123`

**Purpose:**
- Ensures actions are performed under the correct user
- Maintains clear ownership and audit trail

---

### Step 3: Locate the Repository
- Search for the repository:
  ```
  sarah/story-blog
  ```

This is the original repository owned by another developer.

---

### Step 4: Fork the Repository
- Click the **Fork** button in the Gitea UI
- Choose to fork it under the **jon** user account

After forking, a new repository is created:
```
jon/story-blog
```

---

## Verification

Successful completion is confirmed when:
- The repository appears under **jon’s** account
- The repository name matches `story-blog`
- Ownership is clearly shown as `jon`
---

## Key Learnings
- Forking creates a personal copy of a repository
- Developers can work independently without risking the original code
- Git platforms manage forking at the server level
- UI-based workflows are as important as CLI-based tasks
- Forking is the first step toward contributing via pull requests

---

## Interview-Ready Explanation

> “Forking allows developers to create an independent copy of a repository under their own account, enabling safe contributions without direct access to the original project.”

---

## Status
✅ **Day 23 task completed successfully**
