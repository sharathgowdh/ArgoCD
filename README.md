# ArgoCD Kubernetes GitOps Setup

This repository provides a complete setup for deploying applications using **ArgoCD**, a declarative GitOps continuous delivery tool for Kubernetes. It helps automate application deployment and lifecycle management using Git repositories as the source of truth.

## 🚀 Features

- Declarative GitOps deployment with ArgoCD
- Kubernetes-native continuous delivery
- Sync and health status monitoring
- Support for multiple environments
- Easy integration with GitHub repositories

## 🛠️ Prerequisites

- Kubernetes cluster (Minikube, Kind, EKS, GKE, etc.)
- `kubectl` CLI configured
- `argocd` CLI (optional but recommended)
- GitHub account with repository access

## ⚙️ Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/sharathgowdh/ArgoCD.git
   cd ArgoCD
   
## Install ArgoCD in your cluster::
- kubectl apply -f manifests/argocd-install.yaml

## Access the ArgoCD UI:
- kubectl port-forward svc/argocd-server -n argocd 8080:443

## Login to ArgoCD:
- argocd login localhost:8080
