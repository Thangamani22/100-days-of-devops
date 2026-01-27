# Day 29 – Git Pull Request Workflow (Gitea)

## 📌 Objective
Implement a proper Git workflow where changes are not pushed directly to the `master` branch, but instead go through a Pull Request (PR) review and approval process.

---

## 🧠 Scenario Overview
- Direct pushes to `master` are restricted
- Developers work on feature branches
- Changes must be reviewed and approved before merging
- Git repository is hosted on Gitea
- Two users involved:
  - Max – contributor
  - Tom – reviewer

---

## 🔐 Access Details

### Storage Server (SSH)
- User: max  
- Password: Max_pass123  

### Gitea UI
- User (Contributor): max / Max_pass123  
- User (Reviewer): tom / Tom_pass123  

---

## ✅ Steps Performed

### 1️⃣ SSH into Storage Server as Max
```bash
ssh max@storage-server
```

---

### 2️⃣ Verify Repository Contents
- Repository already cloned under Max’s home directory
- Checked existing files
- Verified Sarah’s story is present

```bash
git log
```

Confirmed commit history, author details, and commit messages.

---

### 3️⃣ Confirm Max’s Story Branch
Max has already pushed his story to:
```text
story/fox-and-grapes
```

---

### 4️⃣ Create Pull Request in Gitea UI
- Opened Gitea UI from the top bar
- Logged in as max

Pull Request details:
- Title: Added fox-and-grapes story
- Source branch: story/fox-and-grapes
- Destination branch: master

---

### 5️⃣ Assign Reviewer
- Opened the created PR
- Clicked Reviewers
- Added tom as reviewer

---

### 6️⃣ Review and Merge PR as Tom
- Logged out from Max’s account
- Logged in as tom
- Opened PR: Added fox-and-grapes story
- Reviewed changes
- Approved and merged the PR into master

---

## 🏁 Outcome
- Changes successfully merged into master
- No direct push to master
- Proper review and approval followed

---

## 🧠 Key Learnings
- Master branch should always contain approved and reviewed code
- Pull Requests enforce code quality and accountability
- Reviewers play a critical role in production readiness
- This workflow mirrors real-world DevOps team collaboration

---

## ✅ Status
Task completed successfully – Day 29
