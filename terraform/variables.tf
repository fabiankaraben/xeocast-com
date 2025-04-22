variable "cloudflare_account_id" {
  description = "The Cloudflare Account ID."
  type        = string
}

variable "cloudflare_api_token" {
  description = "The Cloudflare API Token."
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "The name of the Cloudflare Pages project."
  type        = string
  default     = "xeocast-com"
}

variable "production_branch" {
  description = "The production branch name in the GitHub repository."
  type        = string
  default     = "main"
}

variable "github_owner" {
  description = "The owner (user or organization) of the GitHub repository."
  type        = string
  default     = "fabiankaraben" # Assuming from workspace path
}

variable "github_repo_name" {
  description = "The name of the GitHub repository."
  type        = string
  default     = "xeocast-com" # Assuming from workspace path
}

variable "custom_domain" {
  description = "The custom domain to associate with the Cloudflare Pages project."
  type        = string
  default     = "xeocast.com"
} 