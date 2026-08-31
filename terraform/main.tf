terraform {
  required_version = ">= 1.16.0, < 2.0.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.9.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.2.1"
    }
  }
}

provider "kubernetes" {
  config_path    = pathexpand("~/.kube/config")
  config_context = "minikube"
}

variable "nome_projeto" {
  description = "Nome do projeto usado no laboratório"
  type        = string
  default     = "azure-devops-lab"
}

variable "ambiente" {
  description = "Nome do ambiente"
  type        = string
  default     = "local"
}

resource "local_file" "informacoes_lab" {
  filename = "${path.module}/output/aula18.txt"

  content = <<-EOT
    Projeto: ${var.nome_projeto}
    Ambiente: ${var.ambiente}
    Gerenciado por: Terraform
  EOT
}

output "arquivo_criado" {
  description = "Caminho do arquivo criado pelo Terraform"
  value       = local_file.informacoes_lab.filename
}