<div align="left">

Multi-Phase Application Deployment: Docker → Kubernetes → Helm/EKS

PHASE-1

🚀 Flask + MySQL Two-Tier Application (Dockerized)

A fully containerized Two-Tier Application consisting of:

Frontend + Backend: Flask App

Database: MySQL

Containerization: Docker & Dockerfile

Deployment: Multi-container setup using Docker commands

📌 Features

Flask app served via Docker

MySQL database running in a separate container

Persistent data storage using Docker volumes

Proper wait mechanism for MySQL initialization

🏗️ Project Structure
two-tier-app/
│── app.py
│── requirements.txt
│── Dockerfile
│── templates/index.html
│── static/
└── ...

🐳 Docker Commands Used
Build Flask Image
docker build -t flask-app .

Run MySQL Container

docker run -d --name mysql-db \
 -e MYSQL_ROOT_PASSWORD=root \
 -e MYSQL_DATABASE=chatbotdb \
 -p 3306:3306 \
 mysql:8

Run Flask Container

docker run -d --name flask-app \
 --link mysql-db:mysql \
 -p 5000:5000 \
 flask-app

create a Docker compose file

PHASE-2

<img width="1536" height="1024" alt="ChatGPT Image Jan 5, 2026, 06_48_03 PM" src="https://github.com/user-attachments/assets/c4d0607a-5ae3-41fa-90a3-8dd8ae759d1e" />

</div>



