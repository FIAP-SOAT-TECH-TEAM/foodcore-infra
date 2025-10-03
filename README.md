# 🏗️ Food Core Infra

Infraestrutura do projeto para gerenciar pedidos de restaurantes fast-food, desenvolvida como parte do curso de Arquitetura de Software
da FIAP (Tech Challenge).

<div align="center">
  <a href="#visao-geral">Visão Geral</a> •
  <a href="#tecnologias">Tecnologias</a> •
  <a href="#componentes-criados">Componentes Criados</a> •
  <a href="#recursos-provisionados">Recursos provisionados</a> •
  <a href="#trafego-e-segurança">Tráfego e Segurança</a> •
  <a href="#localizacao">Localização</a> •
  <a href="#Performance">Performance</a> •
  <a href="#fluxo-de-deploy">Fluxo de Deploy</a> •
  <a href="#boas-praticas">Boas Práticas</a>
</div><br>

# ☁️ Infraestrutura (Azure)

## 📖 Visão Geral

Este repositório contém os **scripts de IaC (Terraform)** responsáveis por provisionar toda a infraestrutura do projeto:

- **Kubernetes - AKS (Somente a criação do cluster)**
- **Banco de Dados Postgres - Azure Database (Somente Subnet delegada e zonas de DNS)**
- **Azure APIM**
- **Configurações de rede, secrets e storage**

## 🚀 Tecnologias

- **Terraform**
- **Azure AKS**
- **Azure Database for PostgreSQL**
- **Azure API Management (APIM)**
- **Cognito**
- **GitHub Actions** para CI/CD

## 🧩 Componentes Criados

- **Cluster AKS** para rodar a aplicação.
- **Namespace + Secrets + ConfigMaps** no Kubernetes.
- **Postgres gerenciado** com backup e alta disponibilidade.
- **Ingress + APIM** para expor a API de forma segura.
- **Identity Integration** com Cognito para autenticação.

### Recursos provisionados

- **Resource Group**
- **Virtual Network (VNET)** com subnets delegadas e zona de DNS privada
- **AKS (Azure Kubernetes Service)** Somente o Cluster
- **APIM (Azure API Management)**
- **Azure Function**
- **Azure PostgreSQL Flexible Server**
- **ACR (Azure Container Registry)**
- **Application Insights**

> ⚠️ Nenhum recurso Kubernetes (deployments, services, ingress etc.) é criado por este repositório, apenas o **cluster AKS** em si.

### Tráfego e Segurança

- Todo tráfego entre serviços é **privado**:
  - AKS → APIM
  - Azure Function → APIM
  - Azure PostgreSQL Flexible Server → AKS
- Nenhum desses recursos recebe tráfego inbound público.
- Todo acesso ao **AKS** e à **Azure Function** é intermediado via **APIM**.

### Localização

- Todos os recursos foram criados na região **Brazil South** para reduzir latência.
- **Exceção:** o **Cognito**, que por limitações da AWS Academy foi criado no **East US**.
  - Isso aumentou a latência das chamadas à Azure Function, já que ela é invocada como **sub-request em toda requisição ao backend**.
  - Para mitigar, foi configurado **caching no Produto da API no APIM**.

### Performance

- A **Azure Function** foi configurada com **Always On**, reduzindo o problema de **cold start**.
- As requests para o **cognito** possuem um sistema de **caching** no **APIM**, já que o mesmo está provisionado na região East US da AWS e acarreta em uma lentidão

## ⚙️ Fluxo de Deploy

1. Alterações de infraestrutura são feitas via **Pull Request**.
2. **Terraform Plan** roda automaticamente no pipeline.
3. Após aprovação, **Terraform Apply** executa no merge.
4. Infraestrutura é provisionada/atualizada automaticamente.

## 🔒 Boas Práticas

- Uso de **Secrets do GitHub** para dados sensíveis.
- Branch `main` protegida (merge apenas via Pull Request).
- Toda alteração na cloud é feita via **Terraform**, garantindo rastreabilidade.
