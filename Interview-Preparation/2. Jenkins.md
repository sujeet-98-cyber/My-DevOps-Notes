# Top 10 Jenkins Interview Questions and Answers

## 1. What is Jenkins?

**Answer:**  
Jenkins is an open-source automation server used to automate parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery (CI/CD).

---

## 2. What are the key features of Jenkins?

**Answer:**  
- Open-source and free to use  
- Extensible with 1800+ plugins  
- Easy installation and configuration  
- Supports distributed builds (master-agent architecture)  
- Integrates with major tools like Git, Docker, Maven, Kubernetes, etc.

---

## 3. What is a Jenkins pipeline?

**Answer:**  
A Jenkins pipeline is a suite of plugins that support implementing and integrating continuous delivery pipelines into Jenkins using a domain-specific language (DSL).

---

## 4. Difference between Declarative and Scripted Pipeline?

**Answer:**  
| Feature           | Declarative Pipeline       | Scripted Pipeline          |
|-------------------|----------------------------|---------------------------|
| Syntax            | Structured and simpler     | Groovy-based flexible code |
| Error handling    | Built-in                   | Manual                    |
| Readability       | Easier                    | Complex                   |

---

## 5. What is a Jenkinsfile?

**Answer:**  
A `Jenkinsfile` is a text file that contains the definition of a Jenkins Pipeline and is typically stored in the root of your source code repository.

---

## 6. How do you trigger a Jenkins build?

**Answer:**  
- Manually from the Jenkins UI  
- Automatically via SCM webhook (e.g., GitHub push)  
- Scheduled using cron syntax  
- Triggered by other builds or jobs  
- Via REST API

---

## 7. How does Jenkins achieve continuous integration?

**Answer:**  
By automatically pulling code from a version control system, running build/test scripts, and providing instant feedback on changes, Jenkins facilitates early bug detection and integration.

---

## 8. How can Jenkins be integrated with Docker?

**Answer:**  
- Jenkins can build Docker images using Docker CLI in shell steps.  
- Install Docker plugin to manage Docker containers and build agents.  
- Store and push images to Docker Hub or AWS ECR.

---

## 9. What is the use of agents in Jenkins?

**Answer:**  
Agents (also called nodes) are machines that run jobs under the control of the Jenkins controller. They enable distributed builds and scalability.

---

## 10. How to secure Jenkins?

**Answer:**  
- Enable global security  
- Use Matrix-based security or Project-based Matrix Authorization  
- Integrate with LDAP or SSO  
- Use HTTPS for web interface  
- Regularly update plugins and core

---

## Additional Questions

### Q: Can you explain the CICD process in your current project? Or talk about any CICD process that you have implemented?

**A:**  
In the current project we use the following tools orchestrated with Jenkins to achieve CICD: Maven, Sonar, AppScan, ArgoCD, and Kubernetes.

The entire process takes place in 8 steps:  
1. **Code Commit:** Developers commit code changes to a Git repository hosted on GitHub.  
2. **Jenkins Build:** Jenkins is triggered to build the code using Maven. Maven builds the code and runs unit tests.  
3. **Code Analysis:** Sonar is used to perform static code analysis to identify any code quality issues, security vulnerabilities, and bugs.  
4. **Security Scan:** AppScan is used to perform a security scan on the application to identify any security vulnerabilities.  
5. **Deploy to Dev Environment:** If the build and scans pass, Jenkins deploys the code to a development environment managed by Kubernetes.  
6. **Continuous Deployment:** ArgoCD is used to manage continuous deployment. ArgoCD watches the Git repository and automatically deploys new changes to the development environment as soon as they are committed.  
7. **Promote to Production:** When the code is ready for production, it is manually promoted using ArgoCD to the production environment.  
8. **Monitoring:** The application is monitored for performance and availability using Kubernetes tools and other monitoring tools.

---

### Q: What are the different ways to trigger Jenkins pipelines?

**A:**  
- **Poll SCM:** Jenkins periodically checks the repository for changes and automatically builds if changes are detected. This can be configured in the "Build Triggers" section of a job.  
- **Build Triggers:** Using Git plugin to automatically build when changes are pushed to the repository.  
- **Webhooks:** A webhook can notify Jenkins when changes are pushed, triggering automatic builds.

---

### Q: How to backup Jenkins?

**A:**  
Backup these key components:  
- **Configuration:** The `~/.jenkins` folder. Use tools like rsync to back up this directory.  
- **Plugins:** Backup the `plugins` directory located in `JENKINS_HOME/plugins`.  
- **Jobs:** Backup the `jobs` directory located in `JENKINS_HOME/jobs`.  
- **User Content:** Any custom content like build artifacts or scripts.  
- **Database:** If using a database, back it up using the database's native tools (e.g., `mysqldump` for MySQL).

Schedule regular backups using cron or task schedulers.

---

### Q: How do you store/secure/handle secrets in Jenkins?

**A:**  
- **Credentials Plugin:** Store secrets encrypted inside Jenkins securely.  
- **Environment Variables:** Less secure, as they can be visible in logs.  
- **Hashicorp Vault:** Integrate Jenkins with Vault for secure secret management.  
- **Third-party Secret Managers:** Use AWS Secrets Manager, Azure Key Vault, or Google Cloud KMS.

---

### Q: What is the latest version of Jenkins or which version are you using?

**A:**  
Be prepared to mention the Jenkins version you currently use or the latest stable version available, demonstrating familiarity.

---

### Q: What is shared modules in Jenkins?

**A:**  
Shared modules are reusable code and resources across multiple Jenkins jobs, improving maintainability and reducing duplication. Examples include:  
- Libraries (custom Java libs, shell scripts)  
- Shared Jenkinsfiles  
- Common plugins  
- Global variables

---

### Q: Can you use Jenkins to build applications with multiple programming languages using different agents in different stages?

**A:**  
Yes, Jenkins supports multiple build agents on different platforms. You can assign different agents to different stages for building various languages (e.g., Java on one agent, Node.js on another), ensuring correct environment and tools per stage.

---

### Q: How to setup auto-scaling group for Jenkins in AWS?

**A:**  
1. Launch EC2 instance with Jenkins installed as base image.  
2. Create a Launch Configuration with EC2 details.  
3. Create Auto Scaling Group using that launch configuration with min/max instance count.  
4. Configure scaling policies based on metrics like CPU usage.  
5. Set up Load Balancer (ELB) to distribute traffic to instances.  
6. Access Jenkins via load balancer endpoint.  
7. Monitor with CloudWatch to ensure health and scaling effectiveness.

---

### Q: How to add a new worker node in Jenkins?

**A:**  
Navigate to **Manage Jenkins > Manage Nodes > New Node**. Enter a name, select Permanent Agent, configure SSH, and launch the node.

---

### Q: How to add a new plugin in Jenkins?

**A:**  
- **Via CLI:**  
```bash
java -jar jenkins-cli.jar install-plugin <PLUGIN_NAME>
```

- **Via UI:**
 ```bash
Manage Jenkins > Manage Plugins  
Search and install required plugin.
```
---

**Q: What is JNLP and why is it used in Jenkins?**  
**A:**  
JNLP (Java Network Launch Protocol) allows Jenkins agents to connect to the Jenkins master remotely. Agents receive build tasks and return results, enabling distributed builds.

---

**Q: What are some common plugins you use in Jenkins?**  
**A:**  
Be prepared to name a few like:  
- Git Plugin  
- Pipeline Plugin  
- Docker Plugin  
- Credentials Plugin  
- SonarQube Plugin
