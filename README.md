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
-e MYSQL_ROOT_PASSWORD=root \
-e MYSQL_DATABASE=chatbotdb \
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

## 🏗️ Architecture

