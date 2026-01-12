# 🚀 Multi-Phase Application Deployment: Docker → Kubernetes → Helm/EKS

This project demonstrates a complete real-world DevOps workflow by deploying a Flask + MySQL two-tier application in multiple phases:

- Phase 1: Docker (Containerization)
- Phase 2: Kubernetes (Orchestration)
- Phase 3: Helm + EKS (Production Deployment)

---

# 📌 PHASE 1: Flask + MySQL Two-Tier Application (Dockerized)

A fully containerized Two-Tier Application consisting of:

- Frontend + Backend: Flask Application
- Database: MySQL
- Containerization: Docker & Dockerfile
- Deployment: Multi-container setup using Docker & Docker Compose

---

## ✨ Features

- Flask app served via Docker
- MySQL database running in a separate container
- Persistent data storage using Docker volumes
- Proper wait mechanism for MySQL initialization
- Multi-container orchestration using Docker Compose

---

## 🐳 Docker Commands Used

### Build Flask Image

```bash
docker build -t flask-app .

```
**Run MySQL Container**
```bash
docker run -d --name mysql-db \
-e MYSQL_ROOT_PASSWORD=admin\
-e MYSQL_DATABASE=mydb \
-p 3306:3306 \
mysql:5.7
```

**Run Flask APP Container**

```bash
docker run -d --name flask-app \
--link mysql-db:mysql \
-p 5000:5000 \
flask-app
```

**Run Using Docker Compose**

```bash
docker compose up -d --build
```

📌 PHASE 2: Kubernetes Deployment

# Kubeadm Installation Guide

This guide outlines the steps needed to set up a Kubernetes cluster using `kubeadm`.

## Prerequisites

- Ubuntu OS (Xenial or later)
- `sudo` privileges
- Internet access
- t2.medium instance type or higher

---

## AWS Setup

1. Ensure that all instances are in the same **Security Group**.
2. Expose port **6443** in the **Security Group** to allow worker nodes to join the cluster.
3. Expose port **22** in the **Security Group** to allows SSH access to manage the instance..


## To do above setup, follow below provided steps

### Step 1: Identify or Create a Security Group

1. **Log in to the AWS Management Console**:
    - Go to the **EC2 Dashboard**.

2. **Locate Security Groups**:
    - In the left menu under **Network & Security**, click on **Security Groups**.

3. **Create a New Security Group**:
    - Click on **Create Security Group**.
    - Provide the following details:
      - **Name**: (e.g., `Kubernetes-Cluster-SG`)
      - **Description**: A brief description for the security group (mandatory)
      - **VPC**: Select the appropriate VPC for your instances (default is acceptable)

4. **Add Rules to the Security Group**:
  ![AWS Security Group rules](https://github.com/user-attachments/assets/b8558f95-f03d-457f-b94b-896db1215d44)
 
5. **Save the Rules**:
    - Click on **Create Security Group** to save the settings.

### Step 2: Select the Security Group While Creating Instances

- When launching EC2 instances:
  - Under **Configure Security Group**, select the existing security group (`Kubernetes-Cluster-SG`)

> Note: Security group settings can be updated later as needed.



## 🏗️ Architecture

📌 PHASE 2: Flask + MySQL on Kubernetes using Helm (AWS)

This project demonstrates:
- Containerization using Docker
- Kubernetes deployment using Helm charts
- MySQL database integration
- Debugging real production issues (CrashLoopBackOff)
- Deployment on AWS EC2

## Configure AWS instance





