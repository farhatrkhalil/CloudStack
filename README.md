# 🏗️ CloudStack: Enterprise 3-Tier AWS Infrastructure
> **A High-Availability, Secure, and Scalable Cloud Framework built with Terraform**

![Architecture Diagram](architecture-diagram.png)

## 📋 Architectural Overview
This project implements a professional **3-Tier Architecture** designed for enterprise-level reliability. By separating the web, application, and data layers into isolated network zones, this design ensures that the infrastructure is resilient, secure, and easily scalable.

---

## 🏛️ The "Why" Behind the Design

### 1. Multi-Availability Zone (AZ) Redundancy
* **The Design:** Infrastructure is mirrored across two distinct AWS Availability Zones.
* **The "Why":** This ensures **High Availability (HA)**. If an entire AWS data center (AZ) experiences an outage, the Application Load Balancer (ALB) automatically shifts traffic to the healthy zone, resulting in zero downtime for the user.

### 2. Network Isolation (DMZ Pattern)
* **The Design:** Only the Load Balancer and Bastion Host reside in **Public Subnets**. All Application Servers and the Oracle RDS instance are housed in **Private Subnets**.
* **The "Why":** This follows the principle of **Least Privilege**. Private instances have no public IP addresses, making them invisible to the open internet and significantly reducing the attack surface.

### 3. Security Group Chaining
* **The Design:** Security Groups are configured as "layers." The Database tier *only* accepts traffic from the Application tier, not the internet or even the public web tier.
* **The "Why":** It creates a "Defense in Depth" strategy. A breach at the perimeter does not grant access to the data layer.

### 4. NAT Gateway Integration
* **The Design:** Private instances use a NAT Gateway for outbound-only internet access.
* **The "Why":** This allows private application servers to pull security patches and updates from the internet while remaining completely unreachable from external inbound connections.

---

## 🛠️ Technology Stack & Justification

| Tool / Service | Category | Purpose |
| :--- | :--- | :--- |
| **Terraform** | IaC | Ensures 100% reproducible environment and version-controlled infra. |
| **GitHub Actions** | CI/CD | Implements **Shift-Left** validation (linting, security, and plan checks). |
| **Amazon VPC** | Networking | Logical isolation of the cloud resources. |
| **EC2 & ASG** | Compute | Auto-scaling compute power based on real-time demand. |
| **Oracle RDS** | Database | Managed relational database providing automated backups and HA. |
| **tfsec** | Security | Static analysis to catch security misconfigurations before they are deployed. |

---

## 🚀 Operational Strategy

### 🛡️ Shift-Left Security
Before any code is applied to the cloud, it must pass a series of automated checks:
1. **Terraform Validate:** Ensures the configuration is syntactically correct.
2. **Terraform Fmt:** Checks that the code adheres to clean-code standards.
3. **Security Linting:** Uses `tfsec` to scan for open ports or unencrypted storage.

### 💰 FinOps & Cost Optimization
In alignment with cloud financial management best practices, this project utilizes:
* **On-Demand Provisioning:** Infra is only deployed for testing/demo purposes and destroyed immediately after.
* **Free-Tier Eligibility:** Preference for `t3.micro` and `t3.small` instances where possible to demonstrate logic without incurring high costs.

---

## 📁 Repository Structure
```text
├── .github/workflows/      # CI/CD Validation Pipelines
├── vpc.tf                  # Networking: VPC, Subnets, Gateways
├── security.tf             # Security Groups & IAM Roles
├── main.tf                 # Compute (ASG) & Load Balancing
├── rds.tf                  # Database (Oracle) Layer
├── variables.tf            # Input variables for customization
└── providers.tf            # AWS Provider configuration
