# Top 10 Terraform Interview Questions and Answers

---

### 1. What is Terraform?

**Answer:**  
Terraform is an open-source Infrastructure as Code (IaC) tool created by HashiCorp. It allows users to define and provision data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language (HCL).

---

### 2. What are the main features of Terraform?

**Answer:**  
- Infrastructure as Code (IaC)  
- Execution Plans (shows what Terraform will do before applying)  
- Resource Graph (builds dependency graphs)  
- Change Automation (applies only changes)  
- Supports multiple providers (AWS, Azure, GCP, etc.)  
- State management for tracking infrastructure

---

### 3. What is a Terraform state file?

**Answer:**  
Terraform state file (`terraform.tfstate`) keeps track of the resources Terraform manages. It maps Terraform configurations to real-world resources, enabling Terraform to know what exists, what has changed, and what to update or destroy.

---

### 4. How do you manage Terraform state files in a team?

**Answer:**  
Using remote backends like AWS S3 with state locking via DynamoDB, Terraform Cloud, or other supported backends ensures state is shared safely among team members and prevents concurrent modifications.

---

### 5. What is the difference between `terraform plan` and `terraform apply`?

**Answer:**  
- `terraform plan` creates an execution plan showing what changes will be made, without applying them.  
- `terraform apply` applies the changes described in the execution plan and creates/modifies resources.

---

### 6. How do you pass variables to Terraform?

**Answer:**  
Variables can be passed via:  
- Variable definition files (`.tfvars`)  
- Command line using `-var` or `-var-file` flags  
- Environment variables prefixed with `TF_VAR_`  
- Default values in the variable block

---

### 7. What are providers in Terraform?

**Answer:**  
Providers are plugins that interact with APIs of cloud platforms or services like AWS, Azure, Google Cloud, Kubernetes, etc. They define the types of resources that can be managed and the actions Terraform can perform.

---

### 8. What are modules in Terraform?

**Answer:**  
Modules are reusable, self-contained packages of Terraform configuration that encapsulate multiple resources and their configurations. Modules help in organizing complex infrastructure code and promote reusability and maintainability.

---

### 9. How do you handle dependencies between resources in Terraform?

**Answer:**  
Terraform automatically builds a dependency graph by analyzing resource references. Explicit dependencies can be defined using the `depends_on` argument if needed, but usually Terraform infers dependencies from resource attributes.

---

### 10. How do you rollback or destroy resources managed by Terraform?

**Answer:**  
- To rollback, you can modify the Terraform configuration and run `terraform apply` to revert changes.  
- To destroy all managed resources, use `terraform destroy`. This command reads the current state and deletes all resources defined in the configuration.

---

Feel free to ask if you want me to create this as a downloadable `.md` file or add more questions!

