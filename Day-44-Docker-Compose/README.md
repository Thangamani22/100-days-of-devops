# 🚀 100 Days of DevOps -- Day 44

## Docker Compose -- Hosting Static Website using httpd Container

------------------------------------------------------------------------

## 📌 Task Overview

The Nautilus application development team provided static website
content that needed to be hosted using an Apache (httpd) container.

### Requirements:

-   Create a Docker Compose file at: `/opt/docker/docker-compose.yml`
-   Use `httpd:latest` image
-   Container name must be: `httpd`
-   Map host port **6000** to container port **80**
-   Mount host directory `/opt/finance` to container directory
    `/usr/local/apache2/htdocs`
-   Do not modify existing data

Environment: App Server 3 -- Stratos Datacenter

------------------------------------------------------------------------

# 🧠 Core Concepts Explained

## 1️⃣ Why Use a Container Instead of Installing Apache on Host?

-   Isolation from host system
-   No dependency conflicts
-   Easy recreation and portability
-   Infrastructure as Code approach

Containers allow us to keep servers clean and reproducible.

------------------------------------------------------------------------

## 2️⃣ Why Docker Compose?

Docker Compose allows defining infrastructure in YAML format.

Instead of running long `docker run` commands manually, we define:

-   Image
-   Container name
-   Ports
-   Volumes

All inside a single declarative file.

Think of Docker Compose as a blueprint for your environment.

------------------------------------------------------------------------

## 3️⃣ Port Mapping Concept

Format:

host_port:container_port

In this task:

6000:80

Meaning:

When user visits: http://`<server-ip>`{=html}:6000

Traffic is forwarded internally to:

container:80

------------------------------------------------------------------------

## 4️⃣ Volume Mapping Concept

Format:

host_path:container_path

In this task:

/opt/finance:/usr/local/apache2/htdocs

Explanation:

-   `/opt/finance` contains website files on host
-   `/usr/local/apache2/htdocs` is Apache document root inside container
-   Container serves files directly from host directory

This ensures: - Data persists even if container is deleted - No data
modification inside container

------------------------------------------------------------------------

# 🏗 Final docker-compose.yml File

``` yaml
version: '3'

services:
  web-app:
    image: httpd:latest
    container_name: httpd
    ports:
      - "6000:80"
    volumes:
      - /opt/finance:/usr/local/apache2/htdocs
```

------------------------------------------------------------------------

# 🧩 YAML Structure Explained

Docker Compose follows hierarchical indentation.

Structure:

services └── service-name ├── image ├── container_name ├── ports └──
volumes

Important rules:

-   Use 2 spaces for indentation
-   Do not use tabs
-   Ports and volumes must be lists (use `-`)
-   Quotes around port mapping prevent YAML parsing issues

------------------------------------------------------------------------

# 🚀 Deployment Steps

Create directory if not present:

``` bash
sudo mkdir -p /opt/docker
```

Create compose file:

``` bash
sudo vi /opt/docker/docker-compose.yml
```

Run the service:

``` bash
cd /opt/docker
docker compose up -d
```

------------------------------------------------------------------------

# 🔍 Verification

Check running container:

``` bash
docker ps
```

Expected output:

-   Container name: httpd
-   Port mapping: 0.0.0.0:6000-\>80/tcp
-   Status: Up

Test from browser or curl:

``` bash
curl http://localhost:6000
```

------------------------------------------------------------------------

# 🎯 Key Learning Outcomes

-   Understood Infrastructure as Code using Docker Compose
-   Learned proper YAML structure
-   Implemented port mapping
-   Implemented volume mapping
-   Understood container data persistence
-   Differentiated runtime vs persistent storage

------------------------------------------------------------------------

# 🏁 Day 44 Status

httpd container deployed using Docker Compose\
Static content served from host directory\
Port mapping configured successfully\
Persistent volume mapping implemented

------------------------------------------------------------------------

Docker Compose fundamentals mastered.
