terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_pages_project" "pages_project" {
  account_id        = var.cloudflare_account_id
  name              = var.project_name
  production_branch = var.production_branch

  source {
    type = "github"
    config {
      owner             = var.github_owner
      repo_name         = var.github_repo_name
      production_branch = var.production_branch

      # Optional: Enable preview deployments for pull requests
      pr_comments_enabled = true
      # Optional: Enable automatic deployments on pushes to the production branch
      deployments_enabled = true
    }
  }

  # Optional: Build configuration (adjust if needed)
  # build_config {
  #   build_command   = "npm run build"
  #   destination_dir = "dist"
  # }

  # Optional: Deployment configuration
  # deployment_configs {
  #   preview {
  #     environment_variables = {
  #       NODE_VERSION = "18"
  #     }
  #   }
  #   production {
  #     environment_variables = {
  #       NODE_VERSION = "18"
  #     }
  #   }
  # }
} 