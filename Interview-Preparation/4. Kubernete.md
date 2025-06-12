# 🧠 Kubernetes Overview

**Kubernetes** is an open-source platform used for container management, including:

- 🚀 **Deployment automation**
- 📈 **Container scaling**
- ⚖️ **Load balancing**

It automates the **scheduling**, **running**, and **management** of isolated containers across **virtual**, **physical**, or **cloud** environments.

✅ All major cloud providers (like **AWS**, **Azure**, and **GCP**) support Kubernetes.

---

# 🕰️ History of Kubernetes

- 🏗️ Developed by **Google** based on their internal system called **Borg** (later evolved into **Omega**) used to manage thousands of applications and services.
- 📅 In **2014**, Google introduced **Kubernetes** as an open-source project.
- 💻 Written in **Go (Golang)**.
- 🌐 Donated to the **Cloud Native Computing Foundation (CNCF)**.

---

# 🧪 Online Platforms for Kubernetes (K8s) Practice

- 🎮 [Kubernetes Playground](https://labs.play-with-k8s.com/)
- 🧑‍🏫 [Play with Kubernetes Classroom](https://training.play-with-kubernetes.com/)

---

# ☁️ Cloud-Based Kubernetes Services

- 🔷 **GKE** – Google Kubernetes Engine  
- 🔶 **AKS** – Azure Kubernetes Service  
- 🟩 **EKS** – Amazon Elastic Kubernetes Service

---

# 🛠️ Kubernetes Installation Tools

- 💻 **Minikube** – Run Kubernetes locally for learning and development.
- ⚙️ **Kubeadm** – Tool to install and configure Kubernetes clusters manually or semi-automatically.

---

# ⚠️ Problems Before Kubernetes 

- 🔌 **Containers could not communicate with each other**  
  → Difficult to manage distributed applications.

- 📉 **Autoscaling and load balancing were not possible**  
  → Manual intervention was needed to handle traffic and resource spikes.

- 🧩 **Scaling up containers was complex**  
  → Required significant configuration and management effort.

- 🧯 **Containers had to be managed carefully**  
  → No built-in tools for health checks, failover, or rolling updates.

---

# 🌟 Key Features of Kubernetes

- 📈 **Autoscaling**  
  Automatically scales containers based on CPU/memory usage or custom metrics.
  - 🔄 **HPA (Horizontal Pod Autoscaler)**: Changes the number of pods.  
  - 📏 **VPA (Vertical Pod Autoscaler)**: Changes pod resource limits (CPU/RAM).

- ❤️ **Auto-Healing**  
  Restarts failed containers, replaces and reschedules them if nodes die.

- ⚖️ **Load Balancing**  
  Distributes network traffic evenly across containers.

- 🌍 **Platform Independent**  
  Runs on cloud, virtual, or physical machines.

- 🛡️ **Fault Tolerance**  
  Handles node or pod failures without affecting application availability.

- ⏪ **Rollback**  
  Supports rolling back to a previous version of an application.

- 🩺 **Health Monitoring**  
  Monitors container health using liveness and readiness probes.

- 🗂️ **Batch Execution**  
  Supports one-time jobs and batch processing (sequential or parallel).

---

# ⚙️ Features Comparison: Kubernetes vs Docker Swarm

| Feature                  | Kubernetes                                    | Docker Swarm             |
|--------------------------|-----------------------------------------------|-------------------------|
| 🛠️ **Installation & Setup** | Complicated and time-consuming                 | ⚡ Fast and easy           |
| 🐳 **Container Support**    | Works with almost all container types like Docker, containerd, etc. | Works mainly with Docker containers |
| 🖥️ **GUI**                  | ✅ Available                                     | ❌ Not available           |
| 💾 **Data Volumes**         | Shared only with containers in the same pod   | Can be shared with other containers |
| 🔄 **Updates & Rollback**   | Supports progressive updates with health monitoring | Limited support         |
| 📈 **Autoscaling**          | Supports both Horizontal Pod Autoscaling (HPA) and Vertical Pod Autoscaling (VPA) | Limited autoscaling     |
| 📊 **Logging & Monitoring** | Built-in tools available                       | Limited tools           |


---
# ☁️ Kubernetes Architecture Hierarchy

<pre>
☁️ Cluster
  │
  └── 🖥️ Node
        │
        └── 📦 Pod
              │
              └── 🐳 Container
                    │
                    └── ⚙️ Application / Microservice
</pre>

---
# ☸️ Kubernetes Architecture

![K8s Architecture](https://github.com/akash08-ak/AWS-Project-Setup/blob/main/Interview-Preparation/Images/Kubernetes%20Architecture.png)

## 🧠 Control Plane Components

- **API Server**: Central communication point; all control components talk through it.
- **Kube Scheduler**: Assigns Pods to available Nodes based on resource availability.
- **etcd**: A key-value database that stores cluster state (e.g., Pods, nodes, IPs).
- **Controller Manager**: Ensures desired state matches actual state by coordinating with API Server.

## ⚙️ Node/Worker Plane (Data Plane)

- **Kubelet**: Talks to API Server, manages Pods, runs containers via runtime (e.g., Docker).
- **Kube-proxy**: Assigns IPs, enables networking and load-balancing across Pods.
- **Container Runtime**: Tool like Docker, Podman, containerd to run containers.
- **Pod**: Smallest unit in K8s, can contain one or more containers sharing network/storage.

## 📈 **Kubernetes Cluster Flow – Step-by-Step**

1. 🧑‍💻 **User Sends Request**
   - A user (or CI/CD pipeline) submits a YAML file (e.g., `Deployment`, `Service`) to the **API Server**.
   - This YAML defines the **desired state** (e.g., 3 Pods of a web app).

2. 🧭 **API Server Receives & Validates**
   - API Server **validates** the YAML and **stores** it in **etcd** (the database of the cluster).
   - etcd now holds the "desired state" of the cluster.

3. 🔍 **Controller Manager Detects Difference**
   - The **Controller Manager** constantly monitors etcd for any difference between:
     - What the user wants (desired state)
     - What is currently running (actual state)

4. ⚠️ **Mismatch Found**
   - If there’s a difference (e.g., 0 Pods running but 3 requested), the Controller Manager takes **action**.

5. 🧠 **Scheduler Kicks In**
   - The **Scheduler** is triggered via the **API Server**.
   - It picks the **best Node** for the new Pod(s) based on:
     - Available CPU/memory
     - Node affinity
     - Taints and tolerations

6. 🛰️ **Kubelet on Target Node**
   - Once the Node is selected, the **Kubelet** (agent on that Node) receives the instructions from the API Server.
   - Kubelet uses the **Container Runtime** (like Docker or containerd) to **pull images** and **start containers** inside a **Pod**.

7. 🧠 **Kube-proxy Handles Networking**
   - The **Kube-proxy** on the Node assigns a **cluster IP** to the Pod.
   - It updates the **network rules** for service discovery and load balancing.

8. 📝 **Status Sent Back**
   - Node status and Pod health are continuously sent back to the API Server and stored in **etcd**.
   - Now, the **actual state = desired state**, so no further action is taken until the next change.

---
# ⚙️ Key Kubernetes Concepts

![Service&Deployement](https://github.com/akash08-ak/AWS-Project-Setup/blob/main/Interview-Preparation/Images/Deployement%26Service.png)

## 🐳 1. Pods
### **What?**
Pods are the smallest deployable units in Kubernetes. A Pod contains one or more containers (like Docker containers) that share the same network and storage.

### **Real-life example:**
Think of a **delivery box** holding your app and its supporting tools together, shipped as a single unit.

### **Why important?**
Pods let Kubernetes manage your app container(s) as one logical unit.

## 🔁 2. ReplicaSets
### **What?**
ReplicaSets ensure that a specified number of Pod replicas are running at all times. If a Pod crashes or is deleted, the ReplicaSet creates a new one to replace it.

### **Real-life example:**
Imagine a **team of workers on a factory line** where there must always be 5 people working. If someone leaves, another worker immediately takes their place to keep production steady.

### **Why important?**
ReplicaSets provide **high availability** and **resilience** by keeping the desired number of Pods running.

## 🚀 3. Deployments
### **What?**
Deployments manage ReplicaSets and Pods, allowing you to declare the desired state for your app and perform **rolling updates** or **rollbacks** smoothly without downtime.

### **Real-life example:**
Think of a **manager who replaces workers on the factory line gradually** to avoid stopping the production line during shift changes.

### **Why important?**
Deployments enable **easy updates and version control** of your apps in Kubernetes.

## 🚀 4. Services
### **What?**
Services in Kubernetes act as **stable endpoints** that connect Pods to the outside world or other Pods within the cluster. They enable communication by providing a **consistent network interface**, even as Pods are created or deleted.  
When Pods are **deleted and recreated**, their **IP changes**, making direct access difficult—**Services solve this problem** by ensuring connectivity.

### **Real-life Example:**
Think of a **restaurant receptionist** who always takes orders and forwards them to available chefs in the kitchen.  
Even if a chef finishes their shift and leaves, new chefs replace them, and the receptionist ensures orders are directed to whoever is currently available.

### **Why Important?**
- Ensures **consistent access** to Pods, even if they change.
- **Balances traffic** among multiple Pods using load balancing.
- Provides a **stable entry point** for apps, making them accessible outside the cluster.

### **Types of Services**
- **ClusterIP** – Used for **internal communication** within the Kubernetes cluster.  
  🏷️ Example: **Chefs (Pods) in a kitchen** can talk to each other without outside interference.

- **NodeIP** – Allows **communication outside the cluster but within the organization**.  
  🏷️ Example: A **manager or order taker** can interact with chefs but isn’t exposed to external customers.

- **LoadBalancer** – Enables **public access** from outside the organization.  
  🏷️ Example: **Customers can place orders**, which get routed to the manager or order taker.

## 🏷️🔍 5. Labels & Selectors
### **Labels:**
Key-value pairs attached to Kubernetes objects like **Pods, Services, or Deployments** to organize and identify them.

### **Selectors:**
Queries that find and **group objects** based on their labels.

### **Real-life example:**
- **Labels**: Like putting **colored stickers** on boxes to mark their contents, e.g., `environment=dev`, `app=frontend`.
- **Selectors**: Like asking, **“Show me all boxes with red stickers”** to quickly find all development environment pods.

### **Why important?**
Labels and selectors let Kubernetes **group and manage resources efficiently**.

## 🌐 6. Namespaces
### **What?**
Namespaces divide a single Kubernetes cluster into **virtual clusters**.  
This lets **multiple teams** or **projects** share the same physical cluster **without interfering with each other**.

### **Real-life example:**
An **office building with multiple rooms**, where each room is a separate team’s workspace.  
They can work **independently but share the same building infrastructure**.

### **Why important?**
Namespaces provide **resource isolation** and **organization** in large Kubernetes environments.
