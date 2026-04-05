cd# Jerney - Azure DevSecOps Blog Platform

![Azure](https://img.shields.io/badge/Azure-Cloud-blue?logo=microsoftazure)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)
![Docker](https://img.shields.io/badge/Containers-Docker-2496ED?logo=docker)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?logo=githubactions)
![Node.js](https://img.shields.io/badge/Backend-Node.js-339933?logo=node.js)
![React](https://img.shields.io/badge/Frontend-React-61DAFB?logo=react)

## Overview

Jerney is a full-stack blog platform built to demonstrate an end-to-end DevSecOps workflow on Azure.

The project combines:

- A React frontend served through Nginx
- A Node.js and Express backend API
- A PostgreSQL database
- Docker-based local development
- Terraform-based Azure infrastructure
- Kubernetes manifests for AKS deployment
- GitHub Actions for CI/CD, image scanning, and manifest updates

This repository is not only an application repo. It is also an infrastructure and deployment repo that shows how the product moves from code to containers to cloud.

## Product Scope

Jerney is a simple blog platform with:

- Blog post creation
- Blog post editing
- Blog post deletion
- Comment support
- Backend health endpoint
- Containerized frontend and backend services

The backend exposes API routes for posts and comments, while the frontend is built with Vite and served from an Nginx container.

## Architecture

```text
Users
  |
  v
Frontend (React + Nginx) : Port 80
  |
  v
Backend API (Node.js + Express) : Port 5000
  |
  v
PostgreSQL : Port 5432
```

## Tech Stack

### Application

- React
- Vite
- Node.js
- Express
- PostgreSQL

### DevOps and Platform

- Docker
- Docker Compose
- Kubernetes
- Azure Kubernetes Service (AKS)
- Terraform
- GitHub Actions

### Security and Validation

- Trivy image scanning
- Checkov IaC scanning
- Hadolint Dockerfile linting
- ESLint
- npm audit

## Repository Structure

```text
Jerney-Azure-DevSecOps/
|-- backend/
|   `-- src/
|       |-- Dockerfile
|       |-- package.json
|       |-- index.js
|       |-- db.js
|       `-- routes/
|-- frontend/
|   `-- src/
|       |-- Dockerfile
|       |-- package.json
|       |-- index.html
|       |-- nginx.conf
|       |-- vite.config.js
|       `-- src/
|           `-- main.jsx
|-- deploy/
|   |-- jerney-nginx.conf
|   `-- setup.sh
|-- k8s/
|   `-- jerney.yaml
|-- Terraform/
|   |-- main.tf
|   |-- variables.tf
|   |-- outputs.tf
|   |-- provider.tf
|   `-- terraform.tfvars
|-- .github/
|   `-- workflows/
|       `-- ci-cd.yml
|-- docker-compose.yml
`-- README.md
```

## How the Repo Is Organized

This repo supports three main deployment paths:

1. Local containers with Docker Compose
2. Azure infrastructure provisioning with Terraform
3. AKS application deployment with Kubernetes manifests

That means the same application can be:

- developed locally
- packaged into container images
- deployed to Kubernetes
- shipped through CI/CD

## Local Development

### Prerequisites

- Node.js 20+
- npm
- Docker Desktop or Docker Engine
- Git

### Option 1: Run the full stack with Docker Compose

This is the fastest way to start the whole application locally.

```bash
git clone git@github.com:pratikbarabde/Jerney-Azure-DevSecOps.git
cd Jerney-Azure-DevSecOps
docker compose up --build
```

Services:

- Frontend: `http://localhost`
- Backend: available internally on port `5000`
- PostgreSQL: `localhost:5432`

### Option 2: Run frontend and backend manually

Start the backend:

```bash
cd backend/src
npm install
node index.js
```

Start the frontend in another terminal:

```bash
cd frontend/src
npm install
npm run dev
```

Default frontend dev URL:

```text
http://localhost:3000
```

## Environment and Database Configuration

The backend uses these environment variables:

- `PORT`
- `DB_HOST`
- `DB_PORT`
- `DB_USER`
- `DB_PASSWORD`
- `DB_NAME`

In Docker Compose, these are already wired in `docker-compose.yml`.

Database defaults used by the local stack:

- Database: `jerney_db`
- User: `jerney_user`
- Password: `jerney_pass_2026`

## Backend API Notes

The backend includes:

- `GET /api/health`
- post routes under `/api/posts`
- comment routes under `/api/comments`

The backend initializes database tables on startup using PostgreSQL.

## Containerization

The project includes separate Dockerfiles for frontend and backend:

- `backend/src/Dockerfile`
- `frontend/src/Dockerfile`

### Backend container

- Uses `node:20-alpine`
- Installs production dependencies
- Runs the API on port `5000`
- Uses a non-root user
- Uses `dumb-init` for signal handling

### Frontend container

- Builds the Vite frontend
- Serves static files using `nginx:1.27-alpine`
- Exposes port `80`
- Uses a custom Nginx configuration

## Kubernetes Deployment

The Kubernetes manifest is located at:

```text
k8s/jerney.yaml
```

It includes:

- Namespace
- Secret for PostgreSQL credentials
- Azure Disk StorageClass
- PersistentVolumeClaim
- PostgreSQL Deployment and Service
- Backend Deployment and Service
- Frontend Deployment and LoadBalancer Service

### Deploy to Kubernetes

After your images are built and pushed, replace the placeholders in `k8s/jerney.yaml` or let the GitHub Actions workflow update them automatically.

Apply the manifest:

```bash
kubectl apply -f k8s/jerney.yaml
```

Check resources:

```bash
kubectl get all -n jerney
```

## Terraform Infrastructure

Terraform files are in:

```text
Terraform/
```

The current Terraform configuration provisions:

- Azure Resource Group
- Virtual Network
- Subnet
- AKS cluster
- Log Analytics Workspace

### Terraform variables

Important variables include:

- `resource_group_name`
- `location`
- `cluster_name`
- `kubernetes_version`
- `node_count`
- `vm_size`
- `vnet_cidr`
- `subnet_cidr`

### Run Terraform

```bash
cd Terraform
terraform init
terraform plan
terraform apply
```

### Terraform outputs

The configuration exposes:

- cluster name
- kubeconfig
- resource group name

## CI/CD Pipeline

The GitHub Actions workflow is defined in:

```text
.github/workflows/ci-cd.yml
```

The pipeline currently performs:

1. Linting for frontend and backend
2. Dependency audit with `npm audit`
3. Docker image build and push to GHCR
4. Trivy container image scanning
5. Checkov scanning for Terraform and Kubernetes manifests
6. Hadolint checks for Dockerfiles
7. Kubernetes manifest image tag updates on pushes to `main`

### Container image naming

The workflow publishes:

- `ghcr.io/<github-repository>/jerney-backend`
- `ghcr.io/<github-repository>/jerney-frontend`

## Security Notes

Security controls currently present in the repo include:

- non-root containers
- `no-new-privileges` for services in Docker Compose
- read-only filesystem for backend container in Compose
- Trivy image scanning
- Checkov IaC scanning
- Hadolint validation
- Kubernetes secrets for DB config

For production, you should still improve:

- secret management with Azure Key Vault or external secret operators
- TLS termination and HTTPS
- ingress configuration
- managed PostgreSQL instead of self-hosted database pods
- tighter network policies
- proper monitoring, alerts, and dashboards

## Azure Deployment Notes

For Azure, this repo is designed around AKS plus Terraform.

Typical flow:

1. Provision Azure infrastructure with Terraform
2. Build and push images to GHCR
3. Update Kubernetes image references
4. Apply the Kubernetes manifest to AKS
5. Access the frontend through the LoadBalancer service

## Troubleshooting

### Docker Compose issues

- If the frontend is unreachable, verify port `80` is free on your machine
- If the backend fails, check DB environment variables and PostgreSQL health
- If the database fails to start, inspect Docker logs for the `db` service

### Terraform issues

- If Terraform destroys and recreates resources, check whether `name` or `location` changed
- If Terraform is locked, ensure another `terraform apply` is not still running
- If AKS creation fails on a free subscription, check node size quotas and regional availability

### Kubernetes issues

- Make sure image placeholders are replaced before applying manifests
- Confirm your cluster can pull from GHCR if the images are private
- Verify the frontend service uses port `80`

## Future Improvements

- add automated integration tests
- add ingress and TLS with cert-manager
- move secrets to Azure Key Vault
- use managed PostgreSQL
- add Helm charts
- add observability dashboards and alerts
- harden production-grade RBAC and network policies

## Author

Pratik Barabde

DevOps Engineer focused on Azure, Terraform, containers, CI/CD, and cloud-native delivery.
