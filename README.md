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


## Kubeadm Installation Guide on AWS EC2 

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
   - **Allow SSH Traffic (Port 22)**:
      - **Type**: SSH
      - **Port Range**: `22`
      - **Source**: `0.0.0.0/0` (Anywhere) or your specific IP
    
    - **Allow Kubernetes API Traffic (Port 6443)**:
      - **Type**: Custom TCP
      - **Port Range**: `6443`
      - **Source**: `0.0.0.0/0` (Anywhere) or specific IP ranges
 
5. **Save the Rules**:
    - Click on **Create Security Group** to save the settings.

### Step 2: Select the Security Group While Creating Instances

- When launching EC2 instances:
  - Under **Configure Security Group**, select the existing security group (`Kubernetes-Cluster-SG`)

> Note: Security group settings can be updated later as needed


Once AWS EC2 instances are created ssh with the help of provided command in AWS by downloading the pem key

6. **Execute on Both "Master" & "Worker" Nodes once you have clone the repository
   ```bash
   bash two-tier-app-deployment/kubeinstaller/installer.sh
   ```
   
7. **Execute the below script only on Master Node**
   ```bash
   bash kubeinstaller/masterinstaller.sh
   ```
8. **Execute the below commands on "Worker Node" once the installer.sh script is executed**
   ```bash
    # Execute on ALL of your Worker Nodes
    
    # 1. Perform pre-flight checks and reset the node:
    sudo kubeadm reset -f
    
    # 2. Paste the join command you got from the master node and append --v=5 at the end:
    # Example:
    # sudo kubeadm join <control-plane-ip>:6443 --token <token> \
    # --discovery-token-ca-cert-hash sha256:<hash> \
    # --cri-socket "unix:///run/containerd/containerd.sock" --v=5
   ```

   **AWS Instances**
   <br>
   <p align="center">
       <img src="https://github.com/user-attachments/assets/3dace7e7-c90d-4b7b-befc-e8a779ede7f0" width="800">
   </p>
   <br>

    **AWS Security Group Rules**
    <br>
   <p align="center">
       <img src=" https://github.com/user-attachments/assets/b39f2d35-160b-4f31-bc69-2d9a7575473e" width="800">
   </p>
   <br>


## 🏗️ Architecture

   <img src="images/arch.png" width="60%">

   <img width="1340" height="950" alt="ChatGPT Image Jan 5, 2026, 06_48_03 PM" src="https://github.com/user-attachments/assets/f5df5838-3bb9-4ab4-b922-aa1a642007c4" />

 **AWS Security Group Rules**
    ![AWS Security Group rules](https://github.com/user-attachments/assets/b39f2d35-160b-4f31-bc69-2d9a7575473e)

- Now, execute below commands one by one from k8
  
```bash
kubectl apply -f Sql_deployment.yml
kubectl apply -f mysql-svc.yml
kubectl apply -f mysql-pv.yml
kubectl apply -f mysql-pvc.yml
kubectl apply -f mysql-init-configmap.yml
```

Before the deployment of the flask-app run kubectl get svc and copy the mysql cluster IP and paste in the flask-app-deployment.yml env varibale MYSQL_HOST so there is no crashback error

```bash
kubectl apply -f flask-app-deployment.yml
kubectl apply -f flask-app-deployment-svc.yml
```

## Results
- Fully functional Kubernetes cluster with master and worker nodes 
- Multi-tier application deployed successfully and accessible
- All pods running in Running state with healthy status

  ![Result](https://github.com/user-attachments/assets/04f11921-7555-40d8-9883-cdc34e678790)
  ![Pods](https://github.com/user-attachments/assets/e631672c-908f-4594-94f4-915567cb9e3c)


---

# 📌 PHASE 3: Flask + MySQL on Kubernetes using Helm (AWS)


## **Configure AWS instance using above Kubeadm Installation Guide**

**AWS Instnaces for HELM**

![AWS instance Helm](https://github.com/user-attachments/assets/404b0fd4-193a-4c8c-b28d-7d4ed41da7d5)

**AWS Security Group Rules**

![security groups](https://github.com/user-attachments/assets/1e4c5a8e-1e7f-40e4-88ab-8d81b616fe08)

1. **Install HELM on "Master Node"**
   ```bash
   bash HelmInstaller/helmInstaller.sh
   ```
2. **Our Flask-App have depency on MySql first deploy Mysql using helm**
   ```bash
   helm install mysql ./mysql-chart
   ```
3. ** Create a message table in the SQL container
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

Before the deployment of the flask-app run kubectl get svc and copy the mysql cluster IP and paste in the flask-app-chart/values.yaml env varibale MYSQL_HOST so there is no crashback error`

4. **Install flask-app-chart**
   ```bash
   helm install flask-app ./flask-app-chart
   ```
   
4. Results
   ``` bash 
   kubectl get all
   ```
   ![heml kubectll all](https://github.com/user-attachments/assets/52825e72-d20e-4e98-a445-e3bce73e6ae3)
   ![AWS website result](https://github.com/user-attachments/assets/0dc74945-065a-4828-bd97-ab69d8bb706d)

    
   









