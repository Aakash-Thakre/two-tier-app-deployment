
### Docker → Kubernetes → Helm → EKS

This project demonstrates a **complete real-world DevOps workflow** by deploying a **Flask + MySQL two-tier application** across multiple stages — from local containerization to **production-style Kubernetes deployments on AWS using Helm**.

It is designed to showcase **hands-on DevOps, Cloud, and Kubernetes engineering skills** with real infrastructure, real automation, and real production patterns.

---

## 🎯 What This Project Demonstrates

- Designing and deploying a **production-like DevOps pipeline from scratch**
- Containerizing applications using **Docker & Docker Compose**
- Setting up a **self-managed Kubernetes cluster using kubeadm on AWS EC2**
- Deploying applications using **Kubernetes manifests**
- Managing **persistent storage using PV & PVC**
- Using **ConfigMaps** for database initialization
- Packaging Kubernetes manifests into **Helm charts**
- Performing **production-style deployments using Helm**
- Understanding **service discovery, networking, and dependency management in Kubernetes**
- Real-world **debugging and troubleshooting (CrashLoopBackOff, DNS, service issues)**

---

## 🛠️ Tech Stack & Skills Used

- **Containerization:** Docker, Docker Compose  
- **Orchestration:** Kubernetes (kubeadm, EKS)  
- **Packaging:** Helm Charts  
- **Cloud:** AWS EC2, AWS EKS, Security Groups  
- **Kubernetes Concepts:** Deployments, Services, PV, PVC, ConfigMap  
- **Languages & Tools:** Flask, MySQL, Linux, Shell Scripting  
- **DevOps Practices:** Automation, Infra setup, Debugging, Production-style deployment

---

## 🔁 Deployment Flow

1. Build and test the application locally using **Docker & Docker Compose**
2. Deploy the same application on a **self-managed Kubernetes cluster (kubeadm on AWS EC2)**
3. Convert Kubernetes manifests into **Helm charts**
4. Deploy the same stack using **Helm for production-style setup**
5. (Optional / Next Step) Deploy on **AWS EKS**

---

## 🏗️ Architecture

- **Application Tier:** Flask (Backend + API)
- **Database Tier:** MySQL
- **Containerization:** Docker, Docker Compose
- **Orchestration:** Kubernetes (kubeadm & EKS)
- **Packaging:** Helm
- **Cloud:** AWS EC2, AWS EKS
- **High Availability:** Multi-node cluster + LoadBalancer

<p align="center">
  <img src="https://github.com/user-attachments/assets/f5df5838-3bb9-4ab4-b922-aa1a642007c4" width="800">
</p>

---

# 📌 PHASE 1: Dockerized Two-Tier Application

## ✨ Features

- Flask app running in one container
- MySQL running in a separate container
- Persistent storage using Docker volumes
- Environment variable-based configuration
- Multi-container orchestration using Docker Compose

---

## 🚀 Run Using Docker

```bash
docker build -t flask-app .
docker compose up -d --build
📌 PHASE 2: Kubernetes Deployment using kubeadm on AWS EC2
This phase demonstrates:

Manual Kubernetes cluster setup using kubeadm

Real AWS Security Group configuration

Deployment using:

Deployment

Service

PV / PVC

ConfigMap

☁️ AWS Infrastructure Setup
Multiple EC2 instances in same Security Group

Open ports:

22 → SSH

6443 → Kubernetes API

<p align="center"> <img src="https://github.com/user-attachments/assets/3dace7e7-c90d-4b7b-befc-e8a779ede7f0" width="800"> </p> <p align="center"> <img src="https://github.com/user-attachments/assets/b39f2d35-160b-4f31-bc69-2d9a7575473e" width="800"> </p>
⚙️ Cluster Setup
Run on Master & Worker Nodes:

bash
Copy code
bash two-tier-app-deployment/kubeinstaller/installer.sh
On Master Node:

bash
Copy code
bash kubeinstaller/masterinstaller.sh
On Worker Nodes:

bash
Copy code
sudo kubeadm reset -f
# Then run the join command from master
🚀 Deploy Application
bash
Copy code
kubectl apply -f Sql_deployment.yml
kubectl apply -f mysql-svc.yml
kubectl apply -f mysql-pv.yml
kubectl apply -f mysql-pvc.yml
kubectl apply -f mysql-init-configmap.yml
kubectl apply -f flask-app-deployment.yml
kubectl apply -f flask-app-deployment-svc.yml
✅ Results
Multi-node Kubernetes cluster running

All pods healthy

Application accessible via LoadBalancer

<p align="center"> <img src="https://github.com/user-attachments/assets/04f11921-7555-40d8-9883-cdc34e678790" width="800"> </p> <p align="center"> <img src="https://github.com/user-attachments/assets/e631672c-908f-4594-94f4-915567cb9e3c" width="800"> </p>
📌 PHASE 3: Helm-Based Deployment on Kubernetes
This phase demonstrates:

Converting raw YAML into Helm charts

Parameterizing deployments using values.yaml

Production-style application deployment

🚀 Steps
Install Helm:

bash
Copy code
bash HelmInstaller/helmInstaller.sh
Install MySQL:

bash
Copy code
helm install mysql ./mysql-chart
Install Flask App:

bash
Copy code
helm install flask-app ./flask-app-chart
✅ Results
bash
Copy code
kubectl get all
<p align="center"> <img src="https://github.com/user-attachments/assets/0dc74945-065a-4828-bd97-ab69d8bb706d" width="800"> </p> <p align="center"> <img src="https://github.com/user-attachments/assets/52825e72-d20e-4e98-a445-e3bce73e6ae3" width="800"> </p>
⚔️ Challenges & Learnings
Solved Flask ↔ MySQL service discovery issues

Fixed CrashLoopBackOff caused by wrong service DNS / IP

Understood Kubernetes networking & service abstraction

Learned real debugging using kubectl logs, describe, exec

Understood why Helm is critical for scalable deployments

Learned persistent storage management in Kubernetes
