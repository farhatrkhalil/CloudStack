# 🏗️ CloudStack: Enterprise 3-Tier AWS Infrastructure
> **A High-Availability, Secure, and Scalable Cloud Framework built with Terraform**

![Architecture Diagram](architecture-diagram.png)

## 📋 Architectural Overview
This project implements a professional **3-Tier Architecture** designed for enterprise-level reliability. By separating the web, application, and data layers into isolated network zones, this design ensures that the infrastructure is resilient, secure, and easily scalable.

---

## 🏛️ The "Why" Behind the Design

### 1. Multi-Availability Zone (AZ) Redundancy
* **The Design:** Infrastructure is mirrored across two distinct AWS Availability Zones.
* **The "Why":** This ensures **High Availability (HA)**. If an entire AWS data center (AZ) experiences an outage, **Amazon Route 53** and the **Application Load Balancer (ALB)** automatically shift traffic to the healthy zone, resulting in zero downtime.

### 2. Intelligent Traffic Routing (ALB & Target Groups)
* **The Design:** External traffic enters via Route 53 and is managed by an **Application Load Balancer**. The ALB routes traffic to a **Target Group** managed by an **Auto Scaling Group**.
* **The "Why":** This setup allows the system to scale the number of **APP** and **SERVER** instances automatically based on demand while ensuring traffic only hits "healthy" instances.

### 3. Network Isolation (Public vs. Private)
* **The Design:** * **Public Subnets:** House the **Bastion Host** (for admin access) and the **Load Generator**.
    * **Private Subnets:** House the **APP Instance**, **SERVER Instance**, and the **Oracle Database**.
* **The "Why":** Core business logic is unreachable from the public internet. Administrative access is strictly funneled through the Bastion Host.

### 4. Secure Outbound & Monitoring (NAT, S3, CloudWatch)
* **The Design:** Private instances use a **NAT Gateway** for outbound internet access. They are also integrated with **Amazon S3** for object storage and **Amazon CloudWatch** for real-time logging.
* **The "Why":** This allows the APP and SERVER instances to securely store data and send logs to CloudWatch for monitoring without requiring a public IP address.

---

## 🛠️ Technology Stack & Justification

| Tool / Service | Category | Purpose |
| :--- | :--- | :--- |
| **Terraform** | IaC | Ensures 100% reproducible environment and version-controlled infra. |
| **Route 53 & ALB** | Networking | Entry point and intelligent load distribution across AZs. |
| **Auto Scaling Group**| Compute | Manages the lifecycle and scaling of APP/SERVER instances. |
| **Oracle RDS** | Database | Managed relational database providing automated backups and HA. |
| **S3 & CloudWatch** | Ops/Storage | Secure data persistence and centralized infrastructure monitoring. |
| **GitHub Actions** | CI/CD | Implements **Shift-Left** validation (linting and security scans). |

---

## 🚀 Operational Strategy

### 🛡️ Shift-Left Security
Before any code is applied to the cloud, it must pass automated checks:
1. **Terraform Validate:** Ensures the configuration is syntactically correct.
2. **Security Linting:** Uses `tfsec` to scan for open ports or unencrypted storage before deployment.

### 💰 FinOps & Cost Optimization
* **On-Demand Provisioning:** Infra is only deployed for testing and destroyed immediately after.
* **Right-Sizing:** Utilization of `t3.micro` instances to stay within the AWS Free Tier during development.

---

## 📁 Repository Structure
```text
├── .github/workflows/      # CI/CD Validation Pipelines
├── vpc.tf                  # Networking: VPC, Subnets, NAT Gateway, Route 53
├── security.tf             # Security Groups & IAM Roles (S3/CloudWatch access)
├── compute.tf              # Auto Scaling Group, ALB, and Target Groups
├── rds.tf                  # Database (Oracle) Layer
├── variables.tf            # Input variables for customization
└── providers.tf            # AWS Provider configuration
