resource "kubernetes_namespace_v1" "terraform_lab" {
  metadata {
    name = "terraform-lab"

    labels = {
      projeto    = var.nome_projeto
      ambiente   = var.ambiente
      gerenciado = "terraform"
    }
  }
}

resource "kubernetes_config_map_v1" "terraform_info" {
  metadata {
    name      = "terraform-info"
    namespace = kubernetes_namespace_v1.terraform_lab.metadata[0].name
  }

  data = {
    PROJETO    = var.nome_projeto
    AMBIENTE   = var.ambiente
    GERENCIADO = "Terraform"
  }
}

output "namespace_criado" {
  description = "Namespace criado no Kubernetes"
  value       = kubernetes_namespace_v1.terraform_lab.metadata[0].name
}

output "configmap_criado" {
  description = "ConfigMap criado no Kubernetes"
  value       = kubernetes_config_map_v1.terraform_info.metadata[0].name
}