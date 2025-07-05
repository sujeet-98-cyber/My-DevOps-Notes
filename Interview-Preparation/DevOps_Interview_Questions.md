> ## 👋 Introduction
>
> Good morning! My name is **Akash Shewale**.
>
> I completed my **Bachelor’s in Computer Engineering** from *Gokhale Education Society* in 2021. After graduation, I joined **Cognizant** and have been working there for over 3 years.
>
> ### 🌐 My DevOps Experience:
>
> * **Cloud**: AWS & Azure
> * **CI/CD Tools**: Jenkins, Azure Pipelines, GitHub Actions
> * **IaC**: Terraform
> * **Containerization**: Docker & Kubernetes
> * **Security/Quality**: SonarQube, Checkmarx
> * **Artifact Management**: Nexus, GitHub Artifacts
> * **Monitoring**: AWS CloudWatch

---

> ## ✅ Q1: Walk me through a typical Azure Pipeline you designed
>
> In Azure Pipelines, I designed a multi-stage pipeline:
>
> ### 📦 Stages:
>
> 1. **Build Stage**:
>
>    * Build the code
>    * Run unit tests
>    * Perform SAST scan (e.g., Checkmarx)
> 2. **Test Stage**:
>
>    * Execute integration & functional tests
>    * Run VS Test tasks
> 3. **OSS Scan Stage**:
>
>    * Detect vulnerabilities in open-source dependencies
> 4. **Deployment Stage**:
>
>    * Deploy to Dev, Test, and Production environments
>    * Used **approvals & checks** for Production deployments
>
> ### 🔄 Artifact Sharing:
>
> * We had **on-prem agents** on different machines.
> * Created a centralized **SharePath** on a shared file server.
> * **Build outputs** were saved to this SharePath.
> * Later jobs fetched files using **copy tasks**.
> * In hosted agents, we also used `PublishBuildArtifacts` and `DownloadBuildArtifacts`.

---

> ## 🦪 Jenkins Pipeline (AWS)
>
> ### Stages in Jenkins (AWS project):
>
> 1. **Build & Test**: Compile and run unit tests
> 2. **Static Code Analysis**: SonarQube scan (SAST)
> 3. **Artifact Upload**: Store build output in Nexus
> 4. **Dockerize**: Build Docker image
> 5. **Deploy**: Push to **EKS**
> 6. **Monitor**: Integrated **CloudWatch** for monitoring
>
> ### Nexus Repository Structure:

```
https://nexus.company.com/repository/maven-microservices/
├── delight-customer/
├── payment-se
```
