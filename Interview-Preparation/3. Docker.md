# Top 10 Docker Interview Questions and Answers

---

### 1. What is Docker?

**Answer:**  
Docker is a platform that enables developers to automate the deployment, scaling, and management of applications inside lightweight, portable containers. Containers package an application with all its dependencies and run consistently across different environments.

---

### 2. What is the difference between a Docker container and a virtual machine?

**Answer:**  
- **Containers** share the host OS kernel, are lightweight, and start quickly.  
- **Virtual Machines** run a full guest OS with a hypervisor, are heavier, and take longer to start.

---

### 3. What is a Docker image?

**Answer:**  
A Docker image is a read-only template that contains the application code, libraries, dependencies, and configuration files required to run an application inside a container. Images are used to create Docker containers.

---

### 4. What is a Dockerfile?

**Answer:**  
A Dockerfile is a text file containing a set of instructions to build a Docker image. It defines the base image, environment variables, commands to run, files to copy, and other setup needed for the container.

---

### 5. How does Docker handle networking?

**Answer:**  
Docker provides several network drivers like bridge, host, overlay, and macvlan to manage networking between containers and the outside world. By default, Docker containers use a bridge network that allows them to communicate on the same host.

---

### 6. What is Docker Compose?

**Answer:**  
Docker Compose is a tool to define and run multi-container Docker applications. It uses a YAML file (`docker-compose.yml`) to configure application services, networks, and volumes, enabling easy orchestration.

---

### 7. How do you persist data in Docker?

**Answer:**  
Data persistence in Docker is achieved using volumes or bind mounts. Volumes are managed by Docker and stored outside the container filesystem, ensuring data is not lost when containers are removed.

---

### 8. Explain the Docker lifecycle.

**Answer:**  
Docker container lifecycle stages include:  
- **Create:** A container is created from an image.  
- **Start:** The container begins execution.  
- **Stop:** Container execution stops but the container exists.  
- **Restart:** Stops and starts the container.  
- **Remove:** Deletes the container from the host.

---

### 9. What is the difference between `CMD` and `ENTRYPOINT` in a Dockerfile?

**Answer:**  
- `CMD` sets the default command to run in the container, which can be overridden at runtime.  
- `ENTRYPOINT` defines the executable that always runs and is not easily overridden.

---

### 10. How do you optimize Docker images?

**Answer:**  
Some optimization techniques include:  
- Using small base images (like `alpine`).  
- Minimizing the number of layers by combining commands.  
- Removing unnecessary files after build steps.  
- Using `.dockerignore` to exclude files from the build context.

---

# Docker Commands

Some of the most commonly used Docker commands are:

```bash
# List Docker images on the host machine
docker images

# Build image from Dockerfile
docker build

# Run a Docker container
docker run -d   # Run container in background and print container ID
docker run -p   # Port mapping
# Use docker run --help to see more options

# List running containers on the host machine
docker ps

# Stop a running container
docker stop <container_id>

# Start a stopped container
docker start <container_id>

# Remove a stopped container
docker rm <container_id>

# Remove an image from the host machine
docker rmi <image_id>

# Download an image from the configured registry
docker pull <image_name>

# Upload an image to the configured registry
docker push <image_name>

# Run a command in a running container
docker exec -it <container_id> <command>

# Manage Docker networks (create, remove, connect containers)
docker network <command>
```



# Docker Networking

Networking allows containers to communicate with each other and with the host system. Containers run isolated from the host system
and need a way to communicate with each other and with the host system.

By default, Docker provides two network drivers for you, the bridge and the overlay drivers. 

```
docker network ls
```

```
NETWORK ID          NAME                DRIVER
xxxxxxxxxxxx        none                null
xxxxxxxxxxxx        host                host
xxxxxxxxxxxx        bridge              bridge
```


### Bridge Networking

The default network mode in Docker. It creates a private network between the host and containers, allowing
containers to communicate with each other and with the host system.

![image](https://user-images.githubusercontent.com/43399466/217745543-f40e5614-ac34-4b78-85a9-91b24512388d.png)

If you want to secure your containers and isolate them from the default bridge network you can also create your own bridge network.

```
docker network create -d bridge my_bridge
```

Now, if you list the docker networks, you will see a new network.

```
docker network ls

NETWORK ID          NAME                DRIVER
xxxxxxxxxxxx        bridge              bridge
xxxxxxxxxxxx        my_bridge           bridge
xxxxxxxxxxxx        none                null
xxxxxxxxxxxx        host                host
```

This new network can be attached to the containers, when you run these containers.

```
docker run -d --net=my_bridge --name db training/postgres
```

This way, you can run multiple containers on a single host platform where one container is attached to the default network and 
the other is attached to the my_bridge network.

These containers are completely isolated with their private networks and cannot talk to each other.

![image](https://user-images.githubusercontent.com/43399466/217748680-8beefd0a-8181-4752-a098-a905ebed5d2a.png)


However, you can at any point of time, attach the first container to my_bridge network and enable communication

```
docker network connect my_bridge web
```

![image](https://user-images.githubusercontent.com/43399466/217748726-7bb347d0-3736-4f89-bdff-31d240b15150.png)


### Host Networking

This mode allows containers to share the host system's network stack, providing direct access to the host system's network.

To attach a host network to a Docker container, you can use the --network="host" option when running a docker run command. When you use this option, the container has access to the host's network stack, and shares the host's network namespace. This means that the container will use the same IP address and network configuration as the host.

Here's an example of how to run a Docker container with the host network:

```
docker run --network="host" <image_name> <command>
```

Keep in mind that when you use the host network, the container is less isolated from the host system, and has access to all of the host's network resources. This can be a security risk, so use the host network with caution.

Additionally, not all Docker image and command combinations are compatible with the host network, so it's important to check the image documentation or run the image with the --network="bridge" option (the default network mode) first to see if there are any compatibility issues.

### Overlay Networking

This mode enables communication between containers across multiple Docker host machines, allowing containers to be connected to a single network even when they are running on different hosts.

### Macvlan Networking

This mode allows a container to appear on the network as a physical host rather than as a container.

# Docker Volumes

## Problem Statement

It is a very common requirement to persist the data in a Docker container beyond the lifetime of the container. However, the file system
of a Docker container is deleted/removed when the container dies. 

## Solution

There are 2 different ways how docker solves this problem.

1. Volumes
2. Bind Directory on a host as a Mount

### Volumes 

Volumes aims to solve the same problem by providing a way to store data on the host file system, separate from the container's file system, 
so that the data can persist even if the container is deleted and recreated.

![image](https://user-images.githubusercontent.com/43399466/218018334-286d8949-d155-4d55-80bc-24827b02f9b1.png)


Volumes can be created and managed using the docker volume command. You can create a new volume using the following command:

```
docker volume create <volume_name>
```

Once a volume is created, you can mount it to a container using the -v or --mount option when running a docker run command. 

For example:

```
docker run -it -v <volume_name>:/data <image_name> /bin/bash
```

This command will mount the volume <volume_name> to the /data directory in the container. Any data written to the /data directory
inside the container will be persisted in the volume on the host file system.

### Bind Directory on a host as a Mount

Bind mounts also aims to solve the same problem but in a complete different way.

Using this way, user can mount a directory from the host file system into a container. Bind mounts have the same behavior as volumes, but
are specified using a host path instead of a volume name. 

For example, 

```
docker run -it -v <host_path>:<container_path> <image_name> /bin/bash
```

## Key Differences between Volumes and Bind Directory on a host as a Mount

Volumes are managed, created, mounted and deleted using the Docker API. However, Volumes are more flexible than bind mounts, as 
they can be managed and backed up separately from the host file system, and can be moved between containers and hosts.

In a nutshell, Bind Directory on a host as a Mount are appropriate for simple use cases where you need to mount a directory from the host file system into
a container, while volumes are better suited for more complex use cases where you need more control over the data being persisted
in the container.
