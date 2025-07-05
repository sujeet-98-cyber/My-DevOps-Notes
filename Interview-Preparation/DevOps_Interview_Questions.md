 ## 👋 Introduction

 Good morning! My name is **Akash Shewale**.

 I completed my **Bachelor’s in Computer Engineering** from *Gokhale Education Society* in 2021. After graduation, I joined **Cognizant** and have been working there for over 3 years.

 ### 🌐 My DevOps Experience:

 * **Cloud**: AWS & Azure
 * **CI/CD Tools**: Jenkins, Azure Pipelines, GitHub Actions
 * **IaC**: Terraform
 * **Containerization**: Docker & Kubernetes
 * **Security/Quality**: SonarQube, Checkmarx
 * **Artifact Management**: Nexus, GitHub Artifacts
 * **Monitoring**: AWS CloudWatch

---

 ## ✅ Q1: Walk me through a typical Azure Pipeline you designed

 In Azure Pipelines, I designed a multi-stage pipeline:

 ### 📦 Stages:

 1. **Build Stage**:

    * Build the code
    * Run unit tests
    * Perform SAST scan (e.g., Checkmarx)
 2. **Test Stage**:

    * Execute integration & functional tests
    * Run VS Test tasks
 3. **OSS Scan Stage**:

    * Detect vulnerabilities in open-source dependencies
 4. **Deployment Stage**:

    * Deploy to Dev, Test, and Production environments
    * Used **approvals & checks** for Production deployments

 ### 🔄 Artifact Sharing:

 * We had **on-prem agents** on different machines.
 * Created a centralized **SharePath** on a shared file server.
 * **Build outputs** were saved to this SharePath.
 * Later jobs fetched files using **copy tasks**.
 * In hosted agents, we also used `PublishBuildArtifacts` and `DownloadBuildArtifacts`.

---

 ## 🦪 Jenkins Pipeline (AWS)

 ### Stages in Jenkins (AWS project):

 1. **Build & Test**: Compile and run unit tests
 2. **Static Code Analysis**: SonarQube scan (SAST)
 3. **Artifact Upload**: Store build output in Nexus
 4. **Dockerize**: Build Docker image
 5. **Deploy**: Push to **EKS**
 6. **Monitor**: Integrated **CloudWatch** for monitoring

 ### Nexus Repository Structure:

```
https://nexus.company.com/repository/maven-microservices/
├── delight-customer/
├── payment-service/
└── order-service/
```

---

 ## 🚀 Q3: GitHub Actions Workflow from Scratch

 We implemented **GitHub Actions** workflows from the ground up for internal apps.

 ### 🔧 Key Steps:

 1. **Build & Test**: Compile + unit testing
 2. **Scanning**:

    * **OSS Scans** for open-source libraries
    * **SAST** via Checkmarx
 3. **Artifact Management**:

    * Used `upload-artifact` and `download-artifact` actions
 4. **Deployment**:

    * Deployed to on-prem servers
    * Used GitHub-hosted & self-hosted runners

 ### 🔐 Secrets Handling:

 * Used **GitHub Secrets**:

   * **Repository Secrets**: Specific to project
   * **Organization Secrets**: Shared tokens for templates

 It improved our CI/CD by deeply integrating with GitHub Enterprise.

---

 ## 🔍 Q4: SonarQube Setup and Quality Gates

 SonarQube was used in both **Jenkins (AWS)** and **Azure Pipelines**.

 ### Integration Flow:

 * Code pushed to GitHub triggers CI
 * SonarQube scan runs automatically
 * Quality Gate result determines success/failure

 ### Common Issues Detected:

 * Hardcoded credentials
 * Insecure dependencies
 * Code smells and bad practices

 ### ✅ Real Quality Gate:

 * **Bugs = 0**
 * **Vulnerabilities = 0**
 * **Code Coverage ≥ 85%**
 * **Duplications ≤ 5%**

 Pipeline was blocked until the team fixed the issues and scan passed.

---

 ## 🔐 Q5: Secret Management in CI/CD

 I’ve managed secrets in Jenkins, Azure Pipelines, and GitHub Actions.

 ### Jenkins:

 * Used **Credentials Manager**
 * Injected via:

   * `environment {}` → simple variables
   * `withCredentials {}` → complex credentials (username/password pairs)

 ### Azure Pipelines:

 * Used **Service Connections**:

   * Stored tokens for tools like Checkmarx, NuGet, etc.
   * Referenced in YAML and classic pipelines

 ### GitHub Actions:

 * **Repository Secrets**: API keys, tokens
 * **Organization Secrets**: Shared access across repos
 * Injected using:

   * `secrets.MY_SECRET`
   * Used in `env` or `with` blocks to avoid exposing in logs


