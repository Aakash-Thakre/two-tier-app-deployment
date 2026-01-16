# 🚀 Multi-Phase Two Tier Application Deployment: Docker → Kubernetes → Helm/EKS

**This project demonstrates a complete real-world DevOps workflow by deploying a Flask + MySQL two-tier application in multiple phases:**

- Phase 1: Docker (Containerization)
- Phase 2: Kubernetes (Orchestration)
- Phase 3: Helm + EKS (Production Deployment)

----

 **In this project, the following has been designed and implemented:**

- Containerized both the Flask application and MySQL database using Docker
- Created a Docker Compose setup for local development and testing
- Built Kubernetes-ready deployments for both application and database
- Packaged the Kubernetes manifests into Helm charts for:
    - MySQL
    - Flask application
-Implemented configurable deployments using Helm values

### Deployed the complete stack on:
- A self-managed Kubernetes cluster (using kubeadm) for learning
- AWS EKS for production-style deployment
- Exposed the application using a LoadBalancer service

---

## 🔁 Deployment Flow

1. Build and test the application locally using **Docker & Docker Compose**
2. Deploy the same application on a **self-managed Kubernetes cluster (kubeadm on AWS EC2)**
3. Convert Kubernetes manifests into **Helm charts**
4. Deploy the same stack using **Helm for production-style setup**
5. Deploy on **AWS EKS**

----

- ## 📌 Architecture

- Application Tier: Flask (Backend + API)
- Database Tier: MySQL
- Containerization: Docker, Docker Compose
- Orchestration: Kubernetes (Kubeadm & EKS)
- Packaging: Helm Charts
- Cloud: AWS EC2, AWS EKS
- High Availability: Multi-node cluster + LoadBalancer

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

## Step by Step guide for conatinerizing and deploying the application using docker

1. **Execute the commands one by one, this is for Ubuntu**

    ```bash
    sudo apt install
    sudo apt update
    sudo apt install docker.io
    sudo chown $USER /var/run/docker.sock
    docker ps

2. **Now, execute below commands one by one**
   ```bash
   git clone url
   cd two-tier-app-deployment
   docker build . -t flaskapp
   docker images

   docker network create twotier
   docker run -d -p 3306:3306 --network=twotier -e MYSQL_DATABASE=myDB -e MYSQL_USER=admin -e MYSQL_PASSWORD=admin -e MYSQL_ROOT_PASSWORD=admin --name=mysql mysql:5.7

   ```
   ```bash
   docker exec -it 634c54ae7bbb bash
   ```
> [!NOTE]
> Instead of 634c54ae7bbb use the `container Id` of MYSQL.

   ```bash
   mysql -u root -p
   ```
> [!NOTE]
> After run the up command then, Put the password `admin`.

  ```bash
  show databases;
  use myDB
  ```

  ```sql
  CREATE TABLE messages (
         id INT AUTO_INCREMENT PRIMARY KEY,
         message TEXT
  ```

3. **Show your messages in you MYSQL Database**

   ```bash
   select * from messages;
   ```
```bash
   docker run -d -p 5000:5000 --network=twotier -e MYSQL_HOST=mysql -e MYSQL_USER=admin -e MYSQL_PASSWORD=admin -e MYSQL_DB=myDB --name=flaskapp flaskapp:latest
```

***This is all that I deployed two tier flask app using dockerising .
### Build Flask Image

```bash
docker build -t flask-app .
```

**Run Using Docker Compose**

```bash
docker compose up -d --build
```

---

# 📌 PHASE 2: Kubernetes Deployment ON AWS EC2

This phase demonstrates the setup of a Kubernetes cluster on AWS EC2 instances and deployment of applications using Kubernetes manifests. It showcases hands-on experience with:

- Kubernetes cluster creation and configuration
- Application deployment using Deployment, Service, and ConfigMap manifests
- Security group configuration on AWS


### Set up a self-managed Kubernetes cluster using kubeadm on AWS EC2

   a. **AWS Instances**
   <br>
    <p align="center">
       <img src="https://github.com/user-attachments/assets/3dace7e7-c90d-4b7b-befc-e8a779ede7f0" width="800">
    </p>
    <br>
    b. **AWS Security Group Rules**
   <br>
    <p align="center">
       <img src="https://github.com/user-attachments/assets/b39f2d35-160b-4f31-bc69-2d9a7575473e" width="800">
    </p>
   <br>

## Architecture

  <br>
    <p align="center">
       <img src="https://github.com/user-attachments/assets/f5df5838-3bb9-4ab4-b922-aa1a642007c4" width="800">
    </p>
   <br>


**Now, execute below commands one by one from k8 directory**
  
```bash
kubectl apply -f Sql_deployment.yml
kubectl apply -f mysql-svc.yml
kubectl apply -f mysql-pv.yml
kubectl apply -f mysql-pvc.yml
kubectl apply -f mysql-init-configmap.yml
```

> Note: Before the deployment of the flask-app run kubectl get svc and copy the mysql cluster IP and paste in the flask-app-deployment.yml env varibale MYSQL_HOST so there is no crashback error

```bash
kubectl apply -f flask-app-deployment.yml
kubectl apply -f flask-app-deployment-svc.yml
```

## Results
- Fully functional Kubernetes cluster with master and worker nodes 
- Multi-tier application deployed successfully and accessible
- All pods running in Running state with healthy status

  <br>
    <p align="center">
       <img src="https://github.com/user-attachments/assets/04f11921-7555-40d8-9883-cdc34e678790" width="800">
    </p>
   <br>
    <p align="center">
       <img src="https://github.com/user-attachments/assets/e631672c-908f-4594-94f4-915567cb9e3c" width="800">
    </p>
   <br>

---

# 📌 PHASE 3: Flask + MySQL on Kubernetes using Helm (AWS)


1. **Configure AWS instance using above Kubeadm Installation Guide**

2. **Install HELM on "Master Node"**
   ```bash
   bash HelmInstaller/helmInstaller.sh
   ```
3. **Our Flask-App have depency on MySql first deploy Mysql using helm**
   ```bash
   helm install mysql ./mysql-chart
   ```
4. **Create a message table in the SQL container**
   ```bash
   kubectl exec -it <pod-name> -- /bin/sh
   mysql -u root -p
   Enter the password
   use mydb;
   show tables;
   CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT);

   ```

 > Note: Before the deployment of the flask-app run kubectl get svc and copy the mysql cluster IP and paste in the flask-app-chart/values.yaml env varibale MYSQL_HOST so there is no crashback error`

5. **Install flask-app-chart**
   ```bash
   helm install flask-app ./flask-app-chart
   ```

6. **Results**
   ``` bash 
   kubectl get all
   ```
   <br>
    <p align="center">
       <img src="https://github.com/user-attachments/assets/0dc74945-065a-4828-bd97-ab69d8bb706d" width="800">
    </p>
   <br>
    <p align="center">
       <img src="https://github.com/user-attachments/assets/52825e72-d20e-4e98-a445-e3bce73e6ae3" width="800">
    </p>
   
 

    
   









