# Top 10 Ansible Interview Questions and Answers

---

### 1. What is Ansible?

**Answer:**  
Ansible is an open-source automation tool used for configuration management, application deployment, task automation, and IT orchestration. It uses simple YAML-based playbooks to describe automation jobs.

---

### 2. How does Ansible work?

**Answer:**  
Ansible works by connecting to your nodes (servers, devices, etc.) over SSH (or WinRM for Windows) and executes small programs called "Ansible modules" on the nodes. It is agentless, meaning no software needs to be installed on the managed nodes.

---

### 3. What are Ansible Playbooks?

**Answer:**  
Playbooks are YAML files that define a set of tasks to be executed on a group of hosts. They describe automation jobs, including configurations, deployments, and orchestrations, in a human-readable format.

---

### 4. What is an Inventory file in Ansible?

**Answer:**  
An inventory file is a file where you list the managed nodes or hosts that Ansible controls. It can be a simple INI format file or a dynamic script that generates hosts dynamically.

---

### 5. What are Ansible modules?

**Answer:**  
Modules are reusable, standalone scripts that Ansible runs on your nodes. They perform specific tasks like installing packages, managing files, or restarting services. Examples include `yum`, `apt`, `copy`, `service`, and many more.

---

### 6. Explain the difference between Ansible roles and playbooks.

**Answer:**  
- **Playbooks** contain a list of tasks to run on hosts.  
- **Roles** are a way to organize playbooks into reusable components with predefined directory structures, including tasks, handlers, files, templates, and variables.

---

### 7. What is idempotency in Ansible?

**Answer:**  
Idempotency means that running the same Ansible playbook multiple times will not change the system after the first run if the desired state is already achieved. This ensures predictable, consistent results.

---

### 8. How do you handle sensitive data in Ansible?

**Answer:**  
Ansible uses **Ansible Vault** to encrypt sensitive data like passwords, API keys, or certificates. Vault files can be decrypted at runtime using a password or key.

---

### 9. What is the difference between a task and a handler in Ansible?

**Answer:**  
- **Task:** A single action executed on a host (e.g., install a package).  
- **Handler:** Special tasks triggered by other tasks only when a change occurs, typically used for restarting services after configuration changes.

---

### 10. How can you debug Ansible playbooks?

**Answer:**  
You can use the `debug` module to print variables and messages during playbook execution. Additionally, running playbooks with `-v`, `-vv`, or `-vvv` flags increases verbosity for detailed debugging information.

---

Feel free to ask if you want me to generate this as a downloadable `.md` file or add more questions!
