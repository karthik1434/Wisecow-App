# Wisecow Kubernetes Deployment with GitOps, CI/CD, TLS, and Runtime Security

## Overview

This project demonstrates the **containerization, deployment, and secure operation** of the Wisecow application using modern DevOps practices. The application is containerized using Docker, deployed on Kubernetes, and delivered using a GitOps workflow.

Continuous Integration is implemented using GitHub Actions, while Continuous Deployment is handled through **ArgoCD**, enabling automated synchronization between the Git repository and the Kubernetes cluster.

Security is implemented using TLS for encrypted communication and KubeArmor for runtime security enforcement.

---

## Architecture

Developer pushes code → GitHub Repository → GitHub Actions builds Docker image → Image pushed to container registry → ArgoCD detects changes → Kubernetes cluster automatically updates the deployment.

Runtime request flow:

User → HTTPS (TLS) → Ingress → Kubernetes Service → Wisecow Pods → Application Container

---

## Technologies Used

Docker – Containerization of the application
Kubernetes – Container orchestration platform
ArgoCD – GitOps continuous delivery tool
GitHub Actions – CI pipeline automation
KubeArmor – Runtime container security enforcement
Bash – System monitoring script
Python – Application health checker script

---

## Repository Structure

```
wisecow/
│
├── wisecow.sh
├── Dockerfile
├── README.md
│
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── argocd/
│   └── wisecow-argo-application.yaml
│
├── scripts/
│   ├── health_monitor-script.sh
│   └── app-health-checker.sh
│
├── security/
│   └── kubearmor-policy.yaml
│
└── .github/
    └── workflows/
        └── build.yml
```

---

## Docker Containerization

The Wisecow application is containerized using Docker.

The Dockerfile builds a container image containing the application script and required dependencies. The container exposes the application port and runs the wisecow script as the entry point.

Docker image is automatically built and pushed to the container registry using GitHub Actions.

---

## Kubernetes Deployment

The application is deployed on Kubernetes using Infrastructure as Code (IaC).

### Deployment

Defines the desired number of pods running the Wisecow container.

### Service

Exposes the application internally within the Kubernetes cluster.

### Ingress

Provides external access to the application and enables TLS encrypted communication.

---

## Continuous Integration (CI)

Continuous Integration is implemented using GitHub Actions.

When code is pushed to the repository:

1. The workflow is triggered.
2. The Docker image is built.
3. The image is pushed to the container registry.

This ensures every code change produces a new container image automatically.

---

## GitOps Continuous Deployment (CD)

Continuous Deployment is implemented using ArgoCD.

ArgoCD monitors the Git repository and automatically synchronizes the Kubernetes cluster with the manifests stored in the repository.

If the Kubernetes manifests or container image changes, ArgoCD updates the running application automatically.

This approach ensures the cluster state always matches the desired state defined in Git.

---

## TLS Secure Communication

TLS is implemented at the Ingress level to secure communication between users and the application.

All external traffic to the Wisecow service is encrypted using HTTPS, ensuring secure data transmission.

---

## Runtime Security with KubeArmor

KubeArmor provides runtime security for the Kubernetes workload.

A security policy is defined to enforce zero-trust principles by restricting unauthorized process execution within the container.

Example protections include:

* Blocking shell execution inside containers
* Restricting unauthorized system access
* Enforcing container runtime policies

---

## System Health Monitoring Script

A Bash script is included to monitor the health of a Linux system.

The script checks:

* CPU usage
* Memory usage
* Disk utilization
* Running processes

If any metric exceeds predefined thresholds, an alert is printed to the console.

---

## Application Health Checker

A Python script is provided to verify the availability of the deployed application.

The script sends an HTTP request to the application endpoint and checks the HTTP response code to determine whether the application is running correctly.

---

## How to Deploy

Clone the repository

```
git clone https://github.com/<your-username>/wisecow.git
cd wisecow
```

Apply Kubernetes manifests

```
kubectl apply -f k8s/
```

Deploy ArgoCD application

```
kubectl apply -f argocd/application.yaml
```

---

## Security Layers in the Project

Network Security → TLS encryption via Ingress
Cluster Security → Kubernetes RBAC and resource policies
Runtime Security → KubeArmor container policies

---

## Conclusion

This project demonstrates a complete DevOps workflow including:

* Containerization using Docker
* Kubernetes deployment using IaC
* CI/CD pipeline with GitHub Actions
* GitOps deployment using ArgoCD
* TLS secured communication
* Runtime container security with KubeArmor
* Operational monitoring and health checking scripts

The implementation showcases best practices for modern cloud-native application deployment and security.
