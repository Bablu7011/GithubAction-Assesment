# 🚀 GitHub Actions CI/CD Lab Notes

## 📌 Overview

This project demonstrates a complete CI/CD pipeline using GitHub Actions with Docker, reusable workflows, security scanning, and Slack notifications. The pipeline is designed to follow real-world DevOps practices.

---

# ✅ Task 1 – Basic Workflow Setup

## 🎯 Purpose

To understand how GitHub Actions workflows work and how automation is triggered.

## ⚙️ Configuration

* Created workflow file:

  ```
  .github/workflows/docker-ci.yml
  ```
* Trigger: `push` on any branch
* Job runs a simple command to verify workflow execution

## 🔐 Secrets Used

* None

## ✅ Verification

* Checked workflow run in GitHub Actions tab
* Verified successful execution of job

---

# ✅ Task 2 – Docker Build & Push

## 🎯 Purpose

To automate building and pushing Docker images to Docker Hub.

## ⚙️ Configuration

* Created a **multi-stage Dockerfile**:

  * Stage 1 → uses larger Python image for build
  * Stage 2 → uses lightweight Alpine image for runtime
* Added `.dockerignore` to exclude unnecessary files
* Workflow steps:

  * Checkout code
  * Login to Docker Hub
  * Build Docker image
  * Tag image with:

    * `latest`
    * `commit SHA`
  * Push image to Docker Hub

## 🔐 Secrets Used

* `DOCKER_USERNAME` → Docker Hub username
* `DOCKER_PASSWORD` → Docker Hub password

## ✅ Verification

* Workflow executed successfully
* Docker images visible on Docker Hub with correct tags

---

# ✅ Task 3 – Reusable Workflow

## 🎯 Purpose

To reuse CI/CD logic across multiple repositories.

## ⚙️ Configuration

* Created reusable workflow:

  ```
  .github/workflows/docker-ci.yml
  ```
* Used `workflow_call` to accept inputs:

  * `image_name`
  * `tag`
* Created GitHub Release:

  ```
  v1.0.0
  ```

### Caller Workflow:

* Calls reusable workflow using:

  ```
  uses: <repo>@<version>
  ```
* Branch-based tagging:

  * `develop` → `staging-<commit_sha>`
  * `main` → `prod-<commit_sha>`

## 🔐 Secrets Used

* Docker credentials passed securely from caller to reusable workflow

## ✅ Verification

* Workflow triggered on both branches
* Images pushed with correct environment-based tags

---

# ✅ Task 4 – Security & Notifications

## 🎯 Purpose

To enhance the pipeline with security scanning and real-time notifications.

## ⚙️ Configuration

### 🔍 Security (Trivy Scan)

* Integrated Trivy for Docker image scanning
* Configured:

  * Fail only on **CRITICAL vulnerabilities**
  * Ignore HIGH to ensure pipeline usability

### 📢 Slack Notifications

* Added Slack webhook integration
* Notifications:

  * ✅ Success → Image built and pushed
  * ❌ Failure → Pipeline error message

## 🔐 Secrets Used

* `SLACK_WEBHOOK_URL` → Slack Incoming Webhook

## ✅ Verification

* Scan results visible in workflow logs
* Slack messages received in channel
* Pipeline passes when no CRITICAL vulnerabilities are found

---

