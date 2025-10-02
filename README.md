# 🏗️ Food Core Infra

Infraestrutura do projeto para gerenciar pedidos de restaurantes fast-food, desenvolvida como parte do curso de Arquitetura de Software
da FIAP (Tech Challenge).

<div align="center">
  <a href="#visao-geral">Visão Geral</a> •
  <a href="#tecnologias">Tecnologias</a> •
  <a href="#fluxo-de-deploy">Fluxo de Deploy</a> •
  <a href="#componentes-criados">Componentes Criados</a> •
  <a href="#boas-praticas">Boas Práticas</a>
</div><br>

# ☁️ Infraestrutura - Kubernetes + Terraform (Azure)

## 📖 Visão Geral

Este repositório contém os **scripts de IaC (Terraform)** responsáveis por provisionar toda a infraestrutura do projeto:

- **Kubernetes (AKS)**
- **Banco de Dados Postgres (Azure Database)**
- **Azure APIM**
- **Configurações de rede, secrets e storage**

## 🚀 Tecnologias

- **Terraform**
- **Azure AKS**
- **Azure Database for PostgreSQL**
- **Azure API Management (APIM)**
- **GitHub Actions** para CI/CD

## ⚙️ Fluxo de Deploy

1. Alterações de infraestrutura são feitas via **Pull Request**.
2. **Terraform Plan** roda automaticamente no pipeline.
3. Após aprovação, **Terraform Apply** executa no merge.
4. Infraestrutura é provisionada/atualizada automaticamente.

## 🧩 Componentes Criados

- **Cluster AKS** para rodar a aplicação.
- **Namespace + Secrets + ConfigMaps** no Kubernetes.
- **Postgres gerenciado** com backup e alta disponibilidade.
- **Ingress + APIM** para expor a API de forma segura.
- **Identity Integration** com Cognito para autenticação.

## 🔒 Boas Práticas

- Uso de **Secrets do GitHub** para dados sensíveis.
- Branch `main` protegida (merge apenas via Pull Request).
- Toda alteração na cloud é feita via **Terraform**, garantindo rastreabilidade.
