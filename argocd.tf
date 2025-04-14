terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
  }
}


provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  token                  = data.aws_eks_cluster_auth.main.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    token                  = data.aws_eks_cluster_auth.main.token
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
  }
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.2"
  namespace  = "argocd"

  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  depends_on = [aws_eks_node_group.main]
}

data "kubernetes_service" "argocd_server" {
  depends_on = [helm_release.argocd]
  metadata {
    name      = "argocd-server"
    namespace = "argocd"
  }
}
