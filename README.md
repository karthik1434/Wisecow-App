# 🐮 Wisecow on Kubernetes with GitOps + Security

This project provisions a local Kubernetes cluster using **Vagrant** and deploys the **Wisecow application** with **Argo CD**, while integrating **cert-manager**, **Ingress-NGINX**, and **KubeArmor** for TLS, ingress, and runtime security.  
A **CI/CD pipeline** is provided with **GitHub Actions** to build and push Docker images to Docker Hub.

---

## 🚀 Project Overview

### Infrastructure
- **Vagrant + VirtualBox** to provision Kubernetes.  
- **Calico** for networking (CNI).  
- **Helm** for package management.  
- **cert-manager** for TLS certificates.  
- **Ingress-NGINX** for ingress routing.  
- **Argo CD** for GitOps deployment.  
- **KubeArmor** for security enforcement.  

### Application
- **Wisecow App** (fortune + cowsay service).  
- Runs inside Kubernetes.  
- Accessible via 👉 [https://wisecow.local](https://wisecow.local)  

### Automation
- **GitHub Actions** builds and pushes Docker images to Docker Hub.  
- **Argo CD** auto-syncs updates into Kubernetes.  

---

## ⚙️ Cluster Setup with Vagrant

The included `Vagrantfile` automates:

- **Kubernetes Installation**
  - Installs `kubeadm`, `kubelet`, `kubectl`.  
  - Initializes cluster with Calico networking.  

- **Helm Installation**

- **cert-manager**
  - Installs CRDs.  
  - Deploys via Helm.  

- **Ingress-NGINX**
  - Deploys via Helm.  

- **Argo CD**
  - Installs with upstream manifests.  

- **KubeArmor**
  - Installs operator via Helm.  
  - Applies sample DaemonSet config.  

- **TLS Setup**
  - Generates self-signed cert for `wisecow.local`.  
  - Creates Kubernetes TLS secret.  
  - Updates `/etc/hosts` automatically.  

- **Wisecow App Deployment**
  - Managed via Argo CD (`wisecow-argo-application.yaml`).  

---

## 🌐 Accessing the Application

After provisioning the VM:

```sh
vagrant up

## 🐳 CI/Cd Pipeline (GitHub Actions)

- **Trigger:** push to `main` (or tags).  
- **Builds** Docker image for Wisecow.  
- **Pushes** image to Docker Hub (`your-dockerhub-username/wisecow:latest`).  
- **Argo CD auto-syncs** the new image into the Kubernetes cluster.  

### 🔑 Required GitHub Secrets:
- `DOCKERHUB_USERNAME`  
- `DOCKERHUB_TOKEN`  

---

## ✅ Features Implemented

- Automated Kubernetes provisioning with **Vagrant**  
- Ingress with **TLS** for Wisecow  
- GitOps deployment using **Argo CD**  
- CI/CD with **GitHub Actions + Docker Hub**  
- Runtime security using **KubeArmor**  
- Utility scripts:
  - 🖥️ System health monitor  
  - 💾 Backup automation  
  - 🌐 App health checker
  
