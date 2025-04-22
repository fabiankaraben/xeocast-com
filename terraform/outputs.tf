output "pages_project_name" {
  description = "The name of the created Cloudflare Pages project."
  value       = cloudflare_pages_project.pages_project.name
}

output "pages_project_subdomain" {
  description = "The subdomain assigned to the Cloudflare Pages project."
  value       = cloudflare_pages_project.pages_project.subdomain
}

output "pages_project_domains" {
  description = "The list of domains associated with the Cloudflare Pages project."
  value       = cloudflare_pages_project.pages_project.domains
} 