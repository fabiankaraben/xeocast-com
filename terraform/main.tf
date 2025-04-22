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

data "cloudflare_zones" "domain_zone" {
  filter {
    name = var.custom_domain
  }
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
  build_config {
    build_command   = "npm run build"
    destination_dir = "dist"
  }
}

resource "cloudflare_pages_domain" "custom_domain" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.pages_project.name
  domain       = var.custom_domain
}

resource "cloudflare_record" "cname_record" {
  zone_id = data.cloudflare_zones.domain_zone.zones[0].id
  name    = "@" # Represents the root domain
  content = cloudflare_pages_project.pages_project.domains[0] # Use the first *.pages.dev domain
  type    = "CNAME"
  proxied = true
  ttl     = 1 # Automatic TTL

  lifecycle {
    # Ignore changes to the value if Cloudflare updates it automatically
    ignore_changes = [content]
  }
}

resource "cloudflare_record" "www_cname_record" {
  zone_id = data.cloudflare_zones.domain_zone.zones[0].id
  name    = "www"
  content = cloudflare_pages_project.pages_project.domains[0] # Use the same *.pages.dev domain
  type    = "CNAME"
  proxied = true
  ttl     = 1 # Automatic TTL

  lifecycle {
    # Ignore changes if Cloudflare updates it automatically
    ignore_changes = [content]
  }
}

resource "cloudflare_page_rule" "www_redirect" {
  zone_id = data.cloudflare_zones.domain_zone.zones[0].id
  target  = "www.*"
  actions {
    forwarding_url {
      url         = "https://$1"
      status_code = 301 # Permanent Redirect
    }
  }
  priority = 1 # Higher priority means it runs first
}