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
