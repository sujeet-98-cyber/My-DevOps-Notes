# .NET Core Application DevOps Pipeline Overview 🚀

A step-by-step DevOps pipeline tailored for .NET Core applications using AWS services.

---

## 1. Source Code Management 📁

- **Purpose**: Version control  
- **Storage**: GitHub or AWS CodeCommit  

---

## 2. CI/CD Automation ⚙️

- **Tool**: Jenkins  
- **Purpose**: Automate build, test, and deployment processes  
- **Storage**: Amazon S3 (for artifacts, logs, and reports)  

---

## 3. Static Code Analysis 🧪

- **Tool**: SonarQube  
- **Purpose**: Ensure code quality and detect vulnerabilities  
- **Storage**: Amazon RDS (SonarQube database)  

---

## 4. Security Scanning 🛡️

- **Tool**: OWASP Dependency-Check  
- **Purpose**: Detect known vulnerabilities in dependencies  
- **Storage**: Amazon S3 (security scan reports)  

---

## 5. Containerization 🐳

- **Tool**: Docker  
- **Purpose**: Package the .NET Core application into containers  
- **Storage**: Amazon ECR (for Docker images)  

---

## 6. Deployment & Orchestration 🚢

- **Platform**: Amazon EKS (Kubernetes)  
- **Purpose**: Deploy and manage containerized apps  
- **Storage Options**:
  - **Amazon EBS** – for persistent volumes (stateful workloads)  
  - **Amazon EFS** – for shared access across multiple pods  

---

## 7. Monitoring and Logging 📊

- **Tool**: Amazon CloudWatch  
- **Purpose**: Monitor app performance and collect logs  
- **Storage**:
  - **CloudWatch Logs** – to store logs  
  - **CloudWatch Metrics** – to track performance and health data  

---
