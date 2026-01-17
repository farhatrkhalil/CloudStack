.PHONY: help validate format plan apply destroy clean test-local

# Default target
help:
	@echo "🏗️  CloudStack - Enterprise 3-Tier AWS Infrastructure"
	@echo ""
	@echo "Available commands:"
	@echo "  validate     - Validate Terraform configuration"
	@echo "  format       - Format Terraform files"
	@echo "  plan         - Show execution plan (requires AWS credentials)"
	@echo "  apply        - Apply infrastructure changes (requires AWS credentials)"
	@echo "  destroy      - Destroy all resources (requires AWS credentials)"
	@echo "  test-local   - Run local validation without AWS"
	@echo "  clean        - Clean up local files"
	@echo ""
	@echo "📋 For recruiters: This project demonstrates professional DevOps practices"
	@echo "   - Infrastructure as Code with Terraform"
	@echo "   - 3-Tier Architecture (Web/App/Data)"
	@echo "   - Security best practices"
	@echo "   - Automated CI/CD validation"

# Validation commands (no AWS required)
validate:
	@echo "🔍 Validating Terraform configuration..."
	terraform init -backend=false
	terraform fmt -check -recursive
	terraform validate
	@echo "✅ Validation complete!"

format:
	@echo "🎨 Formatting Terraform files..."
	terraform fmt -recursive
	@echo "✅ Formatting complete!"

# AWS deployment commands (requires credentials)
plan:
	@echo "📋 Creating execution plan..."
	terraform plan
	@echo "✅ Plan complete!"

apply:
	@echo "🚀 Applying infrastructure changes..."
	terraform apply
	@echo "✅ Infrastructure deployed!"

destroy:
	@echo "💥 Destroying infrastructure..."
	terraform destroy
	@echo "✅ Infrastructure destroyed!"

# Local testing without AWS
test-local: validate
	@echo "🧪 Running local tests..."
	@echo "✅ All tests passed! No AWS credentials required for validation."

# Cleanup
clean:
	@echo "🧹 Cleaning up local files..."
	rm -rf .terraform/
	rm -f .terraform.lock.hcl
	rm -f *.tfplan
	rm -f terraform.tfstate*
	@echo "✅ Cleanup complete!"
