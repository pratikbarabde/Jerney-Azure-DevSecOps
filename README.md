# Jerney-Azure-DevSecOps

## Overview
🛤️ Jerney — Blog Platform
A Gen-Z vibe blog platform built with a 3-tier architecture — React frontend, Node.js backend, and PostgreSQL database.

## Techstack
TechStack: React  Node.js  PostgreSQL

## Features
✨ Features
📝 Create blog posts with emoji vibes
✏️ Edit your existing posts
🗑️ Delete posts you're not feeling anymore
💬 Comment on posts
🎨 Gen-Z dark UI with glassmorphism and gradients

## Architecture
🏗️ Architecture
┌──────────────┐     ┌──────────────┐      ┌──────────────┐
│   Frontend   │────▶│   Backend    │────▶│  PostgreSQL  │
│   (React +   │◀────│  (Node.js +  │◀────│              │
│    Nginx)    │     │   Express)   │      │              │
│   Port 80    │     │  Port 5000   │      │  Port 5432   │
└──────────────┘     └──────────────┘      └──────────────┘

## Project Structure
📁 Project Structure
Jerney/
├── frontend/                # React (Vite) frontend
│   ├── src/                 # React components & pages
│   ├── nginx.conf           # Nginx config for serving the app
│   └── package.json
├── backend/                 # Node.js Express API
│   ├── src/                 # Routes, DB connection
│   └── package.json
├── deploy/                  # EC2 deployment scripts
│   ├── setup.sh             # One-click EC2 setup script
│   └── jerney-nginx.conf    # Nginx reverse proxy config
└── README.md
