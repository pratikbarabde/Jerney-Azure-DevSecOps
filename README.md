# 🚀 Jerney — Azure DevSecOps Blog Platform

![Azure](https://img.shields.io/badge/Azure-Cloud-blue?logo=microsoftazure)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)
![Docker](https://img.shields.io/badge/Container-Docker-2496ED?logo=docker)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?logo=githubactions)
![Node.js](https://img.shields.io/badge/Backend-Node.js-339933?logo=node.js)
![React](https://img.shields.io/badge/Frontend-React-61DAFB?logo=react)

---

## 🌄 Overview

**Jerney** is a modern Gen-Z inspired blog platform built using a **3-tier architecture** and deployed with **DevSecOps best practices on Azure**.

It combines:

* ⚡ Fast frontend (React + Nginx)
* 🔧 Scalable backend (Node.js + Express)
* 🗄️ Reliable database (PostgreSQL)

With:

* 🔁 CI/CD pipelines
* 🔐 Secure secret management
* 🏗️ Infrastructure as Code (Terraform)

---

## 🧱 Architecture

```
        ┌───────────────┐
        │   Frontend    │
        │ React + Nginx │
        │   Port: 80    │
        └───────┬───────┘
                │
                ▼
        ┌───────────────┐
        │   Backend     │
        │ Node + Express│
        │   Port: 5000  │
        └───────┬───────┘
                │
                ▼
        ┌───────────────┐
        │  PostgreSQL   │
        │   Port: 5432  │
        └───────────────┘
```

---

## ⚙️ Tech Stack

### 🌐 Application

* React (Vite)
* Node.js + Express
* PostgreSQL

### ☁️ Cloud & DevOps

* Azure (Compute, Networking, Key Vault)
* Terraform (Modular Infrastructure)
* Docker (Containerization)
* GitHub Actions (CI/CD)

### 📊 Monitoring & Security

* Azure Monitor / Log Analytics
* DevSecOps integrations (Secrets, Scanning)

---

## ✨ Features

* 📝 Create blog posts with emoji-rich content
* ✏️ Edit and manage posts
* 🗑️ Delete posts easily
* 💬 Comment system
* 🎨 Gen-Z dark UI with glassmorphism
* ⚡ Fast and responsive UI

---

## 📂 Project Structure

```
Jerney/
│
├── frontend/                 # React (Vite) frontend
│   ├── src/
│   ├── package.json
│   └── nginx.conf
│
├── backend/                  # Node.js Express API
│   ├── src/
│   ├── routes/
│   └── package.json
│
├── terraform/                # Infrastructure as Code
│   ├── modules/
│   ├── main.tf
│   ├── variables.tf
│   └── backend.tf
│
├── .github/workflows/        # CI/CD pipelines
│
└── README.md
```

---

## 🔁 CI/CD Pipeline

GitHub Actions pipeline handles:

* ✅ Code build & validation
* 🐳 Docker image build & push
* ☁️ Infrastructure provisioning (Terraform)
* 🚀 Deployment to Azure

---

## 🔐 Security

* Secrets managed via **Azure Key Vault**
* No hardcoded credentials
* Pipeline-level secret injection
* Infrastructure scanned before deployment

---

## 🚀 Getting Started

### 1️⃣ Clone Repo

```bash
git clone git@github.com:Ravi-Theja-pallikonda/Jerney-Azure-DevSecOps.git
cd Jerney-Azure-DevSecOps
```

### 2️⃣ Run Backend

```bash
cd backend
npm install
npm start
```

### 3️⃣ Run Frontend

```bash
cd frontend
npm install
npm run dev
```

---

## 👨‍💻 Author

**Ravi Theja Pallikonda**
DevOps Engineer | Azure | Terraform | CI/CD
