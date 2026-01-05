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
Architecture Diagram
<img width="1536" height="1024" alt="ChatGPT Image Jan 5, 2026, 06_48_03 PM" src="https://github.com/user-attachments/assets/c4d0607a-5ae3-41fa-90a3-8dd8ae759d1e" />

Prerequisites
Ubuntu OS (Xenial or later)
sudo privileges
Internet access
t2.medium instance type or higher
AWS Setup
Ensure that all instances are in the same Security Group.
Expose port 6443 in the Security Group to allow worker nodes to join the cluster.
Expose port 22 in the Security Group to allows SSH access to manage the instance..
To do above setup, follow below provided steps
Step 1: Identify or Create a Security Group
Log in to the AWS Management Console:

Go to the EC2 Dashboard.
Locate Security Groups:

In the left menu under Network & Security, click on Security Groups.
Create a New Security Group:

Click on Create Security Group.
Provide the following details:
Name: (e.g., Kubernetes-Cluster-SG)
Description: A brief description for the security group (mandatory)
VPC: Select the appropriate VPC for your instances (default is acceptable)
Add Rules to the Security Group:

Allow SSH Traffic (Port 22):

Type: SSH
Port Range: 22
Source: 0.0.0.0/0 (Anywhere) or your specific IP
Allow Kubernetes API Traffic (Port 6443):

Type: Custom TCP
Port Range: 6443
Source: 0.0.0.0/0 (Anywhere) or specific IP ranges
Save the Rules:

Click on Create Security Group to save the settings.

</div>



