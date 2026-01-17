# Terraform Backend Configuration
# Uncomment and configure for production use
# terraform {
#   backend "s3" {
#     bucket         = "cloudstack-terraform-state"
#     key            = "infrastructure/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "cloudstack-terraform-locks"
#     
#     # For cross-account access, specify role_arn
#     # role_arn = "arn:aws:iam::ACCOUNT_ID:role/TerraformBackendRole"
#   }
# }

# Alternative: Local backend for development
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
