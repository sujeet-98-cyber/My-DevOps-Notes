## 👋 Introduction

Good morning! My name is Akash Shewale. I completed my Bachelor's in Computer Engineering from Gokhale Education Society in 2021.

After that, I joined Cognizant. Following my training, I was assigned to the Cygnus project where I worked primarily on AWS. I created CI/CD pipelines using Jenkins, managed infrastructure with Terraform, and handled Docker/Kubernetes deployments. I also integrated SonarQube for code scanning and Nexus for artifact management.

Later in 2023, as the project ramped down, I moved to an internal Cognizant apps project where I worked on Azure. I focused on building Azure Pipelines and supporting various teams in deploying their applications.

Recently, I also led the implementation of GitHub Actions from scratch for a new workflow to replace Azure Pipelines.

Overall, I have over 3 years of experience across AWS and Azure cloud environments with strong hands-on DevOps implementation.

---

### Q1. Can you walk me through a typical Azure Pipeline you designed — including stages, approvals, scanning tools, and how you handled artifact sharing between agents?

**Ans:** Sure. In AWS, I designed a Jenkins-based pipeline with the following stages:

* **Build & Unit Testing**: Code was built and tested.
* **Static Code Analysis**: Integrated SonarQube for SAST.
* **Artifact Management**: Stored artifacts in Nexus.
* **Containerization**: Created Docker images.
* **Deployment**: Images were deployed to EKS (Elastic Kubernetes Service).

We used CloudWatch for monitoring.

In Azure, the pipeline had:

* **Build Stage** – with integrated SAST scan.
* **Test Stage** – VS Test
* **OSS Scan Stage** – to detect vulnerable open-source libraries.
* **Deployment Stages** – to dev/test servers and production.

We used approvals and environment checks to control Prod deployment.

---

### Q2. How did you handle the case where your Azure pipeline needed to share artifacts or configuration files between different agents or jobs — especially if they were running on separate machines?

**Ans:** In Azure Pipelines, we had on-prem agents running across multiple servers. To handle artifact sharing, we set up a centralized DevOps SharePath on a shared file server.

During the pipeline, we published build artifacts to that path — organizing them by folders based on app or team. In later stages or separate jobs, we would use copy tasks to fetch required files from SharePath into the staging directory of the current agent.

This allowed different agents to access the same files even if they were on separate machines. In some cases, we also used the PublishBuildArtifacts and DownloadBuildArtifacts tasks when working within Azure-hosted agents.

For Jenkins, we were using a Nexus repository. According to each microservice, we created different paths like:

```
https://nexus.company.com/repository/maven-microservices/
├── delight-customer/
├── payment-service/
└── order-service/
```

---

### Q3. Can you walk me through how you designed a GitHub Actions workflow from scratch for an application deployment?

**Ans:** Sure. We had to implement GitHub Actions workflows from scratch for internal applications. Since we were new to it, we connected with GitHub Support to understand the best practices.

The workflow was similar to our Azure Pipelines:

* Build and Unit Testing
* OSS and SAST scanning using tools like Checkmarx
* Artifact management using upload-artifact and download-artifact actions
* Deployment to our on-prem servers

We used GitHub-hosted and self-hosted runners depending on the stage. For security, we used GitHub Secrets to store API tokens and connection strings — and organization-level tokens for cross-repo access in shared templates.

Overall, it gave us better integration with our GitHub Enterprise Server and streamlined CI/CD without needing Azure Pipelines.

---

### Q4. You mentioned SonarQube in both Jenkins and Azure setups.

**Ans:** Sure. SonarQube was integrated into our Jenkins pipelines in the AWS-based infrastructure. We configured it so that whenever code was pushed to GitHub, Jenkins would trigger the pipeline and run a SonarQube scan as part of the process.

The scan typically flagged issues like:

* Hardcoded credentials or sensitive info
* Dependency vulnerabilities
* Improper parameter validation or potential code smells

If the scan didn’t pass the defined quality gate, we would fail the pipeline and notify the development team. Only after they fixed the vulnerabilities and SonarQube approved the scan, we would proceed with deployments.

This helped ensure we didn’t push insecure or unstable code into production.

Example quality gate in real use:

✅ Passes if:

* Bugs = 0
* Vulnerabilities = 0
* Coverage ≥ 85%
* Duplications ≤ 5%

---

### Q5. How did you manage secrets like API tokens, credentials, or connection strings in your CI/CD pipelines?

**Ans:** Sure. I’ve handled secret management across all three CI/CD platforms I’ve worked with.

In Jenkins, we used the Credential Manager to securely store API tokens, usernames, and passwords — mainly for integrations like SonarQube and Nexus. These credentials were injected into the pipeline jobs as environment variables.

* `environment {}` is declarative, simple, and great for single-value secrets.
* `withCredentials()` is needed when you have multiple parts, like both username and password, or complex objects like files.

In Azure Pipelines, we used Service Connections to securely manage credentials for tools like Checkmarx, Black Duck, and NuGet package restores. These service connections stored tokens and were referenced in pipeline tasks.

In GitHub Actions, we used both Repository Secrets (specific to a single repo) and Organization Secrets (shared across repos). For example, Checkmarx tokens were stored at the org level, while internal API keys were stored at the repo level. This prevented hardcoding and followed GitHub’s secret management best practices.

In all cases, secrets were referenced securely through environment variables or secret inputs to avoid exposure in logs.

---

### Q6. How do you manage different environments (DEV, STAGE, PROD) in your Jenkins pipelines?

We manage environments using **branch-based deployment**.

* For example:

  * `develop` → deploys to **DEV server**
  * `release` → goes to **STAGE/SIT**
  * `main` or `prod` → deploys to **PROD**

Inside the Jenkinsfile, we use `env.BRANCH_NAME` or pipeline parameters to conditionally decide which environment to deploy to.

All environment-specific **credentials** like API tokens or DB passwords are stored in **Jenkins Credentials Manager**, and used with `withCredentials`.

We also organize Jenkins jobs in **folders by service and environment**, like:

```
/OrderService/DEV  
/OrderService/STAGE  
/OrderService/PROD  
```

This helps manage access and approvals easily.

---

### Q7. How do you handle rollback in Jenkins if a deployment fails?

We follow three main steps:

1. **Store old builds in Nexus**:
   Jenkins pushes each successful build (e.g., `v2.4.3`) to Nexus.
   If a newer build fails, we simply deploy the older `.jar` or Docker image from Nexus.

2. **Tag the Git commit**:
   Before deploying, we use `git tag v2.4.3`.
   So if rollback is needed, we can just `git checkout v2.4.3`.

3. **Use a rollback Jenkins job**:
   Some projects have a dedicated rollback pipeline.
   It asks for version (e.g., `2.4.3`) → pulls from Nexus → redeploys.

This avoids panic in production — we always know how to go one step back.

---

### Q8. If Jenkins fails to upload an artifact to Nexus, how would you troubleshoot it?

1. **Check logs** in Jenkins — is it a permission issue (403) or timeout?

2. **Verify the repo type** — maybe you're pushing a SNAPSHOT to a RELEASE repo.

3. **Check Jenkins credentials** — is the Nexus token/API key expired or incorrect?

4. **Check Nexus itself** — maybe the repository is full or read-only.

5. **Try a manual upload** using `curl` or Maven — to check if issue is with Jenkins or Nexus.

This process helps quickly isolate the root cause.

---

### Q9. How do you version microservices in Jenkins and Nexus?

We use **semantic versioning**:

* **SNAPSHOT builds** (e.g., `1.0.5-SNAPSHOT`) → for dev/testing  → pushed to `snapshots` repo (gets overwritten)
* **RELEASE builds** (e.g., `1.0.5`) → for PROD  → pushed to `releases` repo (permanent and rollback-friendly)

📌 Example:

* During dev, we push `v1.0.5-SNAPSHOT` daily
* Once it's tested, we release `v1.0.5` to `releases` repo

In Jenkins:

* We use version from `pom.xml` (Maven)
* Or inject it via Git tag or pipeline variable

👍 **Azure Equivalent (Your Setup)**:
Since you don’t use Nexus, you store artifacts in shared folders like:

```
\\DevOpsShare\PaymentService\develop\v1  
\\DevOpsShare\PaymentService\release\v2
```

This gives similar tracking as SNAPSHOT/RELEASE folders in Nexus.

---

### Q10. How do you secure artifacts in Nexus and control access?

We use **Role-Based Access Control (RBAC)**:

* **Dev Team** → read/write in `dev-repo`
* **QA Team** → read-only in `stage-repo`
* **Jenkins** → uses a service user or token to push to `release-repo`

Other practices:

* Use **private repos** for internal builds
* Integrate Nexus with **LDAP/AD** for company login
* Use **API tokens** with limited scope (not full admin)
* Some companies also use **IP whitelisting** to restrict access from unknown systems

🔐 This ensures that only trusted tools and users can access artifacts and deploy them safely.

---
