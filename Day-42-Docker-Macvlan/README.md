# 🚀 100 Days of DevOps -- Day 42: Create a Docker Network

## Docker Networking (macvlan) -- Complete Guide

------------------------------------------------------------------------

## 📌 Task Summary

The Nautilus DevOps team required creation of a Docker network with the
following specifications:

-   Network Name: **beta**
-   Driver: **macvlan**
-   Subnet: **10.10.1.0/24**
-   IP Range: **10.10.1.0/24**
-   Environment: App Server 3 (Stratos DC)

------------------------------------------------------------------------

# 🧠 Core Concept -- Why Docker Networking?

Think of:

-   🏢 Server = Apartment building\
-   🏠 Containers = Flats inside building\
-   🛣 Docker network = Roads connecting flats

Without a network → containers cannot communicate.

Docker networking allows containers to: - Talk to each other - Talk to
the host - Talk to external systems

------------------------------------------------------------------------

# 🌐 Types of Docker Networks

  Network Type   Purpose
  -------------- ---------------------------------------------
  bridge         Default internal network (private to host)
  host           Container shares host network
  overlay        Multi-host communication
  macvlan        Container acts like physical machine on LAN

------------------------------------------------------------------------

# 🔥 What Makes macvlan Special?

Normal bridge network: - Containers are hidden behind NAT - Outside LAN
cannot see them directly

macvlan network: - Each container gets its own MAC address - Each
container behaves like a real machine on the network - No NAT involved -
Direct LAN visibility

### 🧠 Memory Trick

**macvlan = Make Container Act Like LAN device**

------------------------------------------------------------------------

# 📘 Subnet vs IP Range (Very Important)

### Subnet

Defines the full network boundary.

Example: 10.10.1.0/24\
→ 256 total IP addresses

### IP Range

Defines which IPs Docker can assign to containers inside that subnet.

Think of it as:

-   Subnet = Entire street\
-   IP Range = Houses available for tenants

IP Range must always fall inside the Subnet.

------------------------------------------------------------------------

# ⚙ macvlan Requires a Parent Interface

macvlan attaches to a physical interface.

Cannot use: - lo (loopback) - docker0 (Docker bridge)

Must use: - Primary physical interface (commonly eth0 in labs)

------------------------------------------------------------------------

# 🛠 Implementation -- Day 42 Command

``` bash
docker network create --driver macvlan --subnet=10.10.1.0/24 --ip-range=10.10.1.0/24 -o parent=eth0 beta
```

------------------------------------------------------------------------

# 🔎 Verification Steps

``` bash
docker network ls
```

``` bash
docker network inspect beta
```

Verify:

-   Driver = macvlan
-   Subnet = 10.10.1.0/24
-   IP Range = 10.10.1.0/24

------------------------------------------------------------------------

# 🚨 Key Learning Takeaways

-   macvlan makes containers behave like real network devices
-   Subnet defines network boundary
-   IP range defines assignable addresses
-   Parent interface connects containers to physical LAN
-   Cannot use docker0 as parent

------------------------------------------------------------------------

# 🎯 Real-World Use Cases

-   Legacy systems requiring direct LAN IP
-   Network monitoring tools
-   Appliances running inside containers
-   When NAT is not acceptable

------------------------------------------------------------------------

# 🏁 Day 42 Status

✅ Docker macvlan network created successfully\
✅ Understood subnet vs ip-range\
✅ Understood parent interface importance\
✅ Concept locked with real-world analogy

------------------------------------------------------------------------

🔥 Day 42 Complete.
