# Top 10 Interview Questions & Answers for DevOps Technologies

---

## Jenkins 🚀

1. **What is Jenkins?**  
   Jenkins is an open-source automation server used for continuous integration and delivery. It helps automate building, testing, and deploying software.

2. **What are Jenkins Pipelines?**  
   Pipelines define the entire build process as code using Declarative or Scripted syntax, enabling complex workflows.

3. **How do you create a Jenkins job?**  
   You create jobs via the Jenkins dashboard, choosing Freestyle or Pipeline, then configure build steps and triggers.

4. **What are Jenkins plugins?**  
   Plugins add new features and integrations, like Git, Docker, and notifications, extending Jenkins capabilities.

5. **How to secure Jenkins?**  
   Use authentication, authorization, SSL, restrict user access, and keep Jenkins and plugins updated.

6. **What is a Jenkinsfile?**  
   A Jenkinsfile is a text file that contains Pipeline code, defining the CI/CD process in version control.

7. **How do you trigger Jenkins jobs?**  
   Jobs can be triggered manually, by SCM commits, scheduled timers, or webhooks.

8. **Difference between Declarative and Scripted Pipelines?**  
   Declarative syntax is simpler and structured, while Scripted is flexible and uses Groovy code.

9. **How to manage Jenkins agents?**  
   Agents run jobs remotely and can be static or dynamically provisioned, e.g., via Kubernetes.

10. **Common Jenkins environment variables?**  
    Variables like `BUILD_NUMBER`, `JOB_NAME`, and `WORKSPACE` provide job info during builds.

---

## Docker 🐳

1. **What is Docker?**  
   Docker is a platform to containerize applications, making them portable and consistent across environments.

2. **What is a Docker image?**  
   An image is a read-only template used to create containers.

3. **What is a Docker container?**  
   A container is a running instance of an image, isolated but lightweight.

4. **How is a Dockerfile structured?**  
   It contains instructions like FROM, RUN, COPY, CMD to build an image step-by-step.

5. **What is Docker Hub?**  
   Docker Hub is a cloud registry for storing and sharing Docker images publicly or privately.

6. **How do you persist data in Docker?**  
   Data persistence is handled using volumes or bind mounts to store data outside containers.

7. **Difference between Docker containers and VMs?**  
   Containers share the host OS kernel; VMs run full OS instances, making containers more lightweight.

8. **How do you network Docker containers?**  
   Docker uses networks like bridge, host, and overlay for container communication.

9. **What is Docker Compose?**  
   Docker Compose defines and runs multi-container applications with YAML configuration files.

10. **How to optimize Docker images?**  
    Use multi-stage builds, reduce layers, and choose minimal base images.

---

## Kubernetes ☸️

1. **What is Kubernetes?**  
   Kubernetes is a platform to automate deployment, scaling, and management of containerized applications.

2. **What are Pods?**  
   Pods are the smallest deployable units that host one or more containers.

3. **What is a Node?**  
   A node is a worker machine in Kubernetes that runs pods.

4. **What is a Deployment?**  
   Deployments manage ReplicaSets and Pods to maintain desired application state.

5. **What is a Service?**  
   Services expose pods and provide stable network endpoints.

6. **How does Kubernetes handle scaling?**  
   Supports manual scaling and autoscaling via Horizontal Pod Autoscalers.

7. **What is a Namespace?**  
   Namespaces partition cluster resources into virtual groups.

8. **What is ConfigMap and Secret?**  
   ConfigMap stores config data; Secret holds sensitive info securely.

9. **Role of kube-apiserver?**  
   It acts as the Kubernetes control plane’s API frontend.

10. **How to update apps in Kubernetes?**  
    Use rolling updates via Deployments for zero downtime.

---

## Terraform 🌍

1. **What is Terraform?**  
   Terraform is an Infrastructure as Code tool to provision and manage cloud resources declaratively.

2. **What is a Terraform provider?**  
   Providers enable Terraform to manage resources for specific platforms like AWS or Azure.

3. **What are Terraform state files?**  
   State files keep track of real-world infrastructure managed by Terraform.

4. **Difference between `terraform apply` and `terraform plan`?**  
   `plan` previews changes; `apply` executes them.

5. **What is a Terraform module?**  
   Modules are reusable groups of Terraform configuration files.

6. **How does Terraform handle dependencies?**  
   Terraform builds a dependency graph to determine resource creation order.

7. **What is a Terraform workspace?**  
   Workspaces allow managing multiple environments with the same configs.

8. **How to handle sensitive variables?**  
   Use environment variables, Vault, or mark them sensitive in configs.

9. **What if Terraform state file is deleted?**  
   Terraform loses track of resources; manual import or recreation is needed.

10. **How to test Terraform code?**  
    Use `terraform validate`, `terraform fmt`, or tools like Terratest.

---

## Ansible 🛠️

1. **What is Ansible?**  
   Ansible is an automation tool for configuration management and application deployment.

2. **What is an Ansible Playbook?**  
   Playbooks are YAML files defining automation tasks for managed hosts.

3. **What are Ansible modules?**  
   Modules are units of work like installing packages or managing files.

4. **How does Ansible connect to nodes?**  
   Ansible connects over SSH without requiring agents.

5. **What is an inventory file?**  
   It lists hosts or groups managed by Ansible.

6. **Difference between `ansible` and `ansible-playbook`?**  
   `ansible` runs ad-hoc commands; `ansible-playbook` executes playbooks.

7. **What are roles?**  
   Roles organize playbooks into reusable components.

8. **How do you handle variables?**  
   Variables can be defined in inventory, playbooks, or external files.

9. **What is Ansible Galaxy?**  
   Galaxy is a hub for sharing and downloading Ansible roles.

10. **How to secure sensitive data?**  
    Use Ansible Vault to encrypt passwords and secrets.

---

*Good luck with your interviews!*