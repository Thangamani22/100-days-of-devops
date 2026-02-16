# 🚀 100 Days of DevOps -- Day 43

## Docker Port Mapping -- Nginx Container Deployment

------------------------------------------------------------------------

## 📌 Task Summary

The Nautilus DevOps team required deployment of an Nginx-based container
with external access configuration.

### Requirements:

-   Pull `nginx:alpine` image
-   Create container named `news`
-   Map host port **3003** to container port **80**
-   Keep container running

Environment: Application Server 1 (Stratos Datacenter)

------------------------------------------------------------------------

# 🧠 Core Concept -- What is Port Mapping?

Containers run in isolation.\
By default, services inside a container are **not accessible from
outside**.

Port mapping connects:

Host Port → Container Port

This allows external traffic to reach the service running inside the
container.

------------------------------------------------------------------------

# 🏠 Real-World Analogy

-   Container = Shop inside a mall\
-   Nginx listens on port 80 (inside the shop)\
-   Host port 3003 = Mall entrance gate\
-   Port mapping = Security directing visitors to the correct shop

When users access:

http://`<server-ip>`{=html}:3003

Traffic is forwarded internally to:

container:80

------------------------------------------------------------------------

# ⚙ Implementation Steps

## Step 1 -- Pull the Image

``` bash
docker pull nginx:alpine
```

Why `alpine`? - Lightweight - Faster pull - Smaller attack surface

------------------------------------------------------------------------

## Step 2 -- Run the Container with Port Mapping

``` bash
docker run -d --name news -p 3003:80 nginx:alpine
```

------------------------------------------------------------------------

# 🔎 Command Breakdown

  Option         Meaning
  -------------- -----------------------------------------
  -d             Run container in detached mode
  --name news    Assign container name
  -p 3003:80     Map host port 3003 to container port 80
  nginx:alpine   Image used

------------------------------------------------------------------------

# 🔍 Verification

Check running container:

``` bash
docker ps
```

Expected output: - Container name: news - Ports: 0.0.0.0:3003-\>80/tcp -
Status: Up

------------------------------------------------------------------------

# 🌐 Testing the Service

Using curl:

``` bash
curl http://localhost:3003
```

Expected response: "Welcome to nginx!"

------------------------------------------------------------------------

# 🚨 Important Notes

-   If port 3003 is already in use, Docker will throw a port allocation
    error.
-   Port mapping is required for external accessibility.
-   If the container stops, the mapped port becomes inactive.
-   `docker run` = create + start in a single command.

------------------------------------------------------------------------

# 🎯 Key Learning Outcomes

-   Understood container isolation
-   Learned how to expose services using `-p`
-   Differentiated host port vs container port
-   Verified running containers and port bindings
-   Understood production-level port mapping behavior

------------------------------------------------------------------------

# 🏁 Day 43 Status

✅ Nginx image pulled\
✅ Container created and running\
✅ Port 3003 successfully mapped to container port 80\
✅ Service accessible externally

------------------------------------------------------------------------

🔥 Day 43 Complete -- Docker Port Mapping Mastered.
