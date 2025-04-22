# Terraform Configuration for Cloudflare Pages

This directory contains Terraform configuration to provision a Cloudflare Pages project connected to a GitHub repository.

## Prerequisites

1.  **Terraform**: Install Terraform CLI (version 1.0 or later).
2.  **Cloudflare Account**: You need a Cloudflare account.
3.  **Cloudflare API Token**: Create a Cloudflare API token with the necessary permissions:
    *   Account Permissions:
        *   `Account Settings`: `Read`
        *   `Cloudflare Pages`: `Edit`
    *   Zone Permissions (for the zone containing your custom domain):
        *   `DNS`: `Edit`
        *   `Zone`: `Read`
        *   `Zone Rulesets`: `Edit`
4.  **Cloudflare Account ID**: Find your Cloudflare Account ID in the Cloudflare dashboard.

## Setup

1.  **Clone the repository** (if you haven't already).
2.  **Navigate to this directory**: `cd terraform`

## Variables

This configuration requires the following variables:

*   `cloudflare_account_id`: Your Cloudflare Account ID.
*   `cloudflare_api_token`: Your Cloudflare API Token (mark as sensitive).

You can provide these variables in several ways:

*   **Environment Variables**: Set `TF_VAR_cloudflare_account_id` and `TF_VAR_cloudflare_api_token`.
    ```bash
    export TF_VAR_cloudflare_account_id="your_account_id"
    export TF_VAR_cloudflare_api_token="your_api_token"
    ```
*   **Terraform Variable File (`.tfvars`)**: Create a file named `terraform.tfvars` (or `*.auto.tfvars`) in this directory:
    ```hcl
    # terraform.tfvars
    cloudflare_account_id = "your_account_id"
    cloudflare_api_token  = "your_api_token"
    ```
    **Note:** Do not commit `terraform.tfvars` if it contains sensitive information like the API token. Add it to your `.gitignore` file.

Optional variables (with defaults):
*   `project_name`: Defaults to `xeocast-com`.
*   `production_branch`: Defaults to `main`.
*   `github_owner`: Defaults to `fabiankaraben`.
*   `github_repo_name`: Defaults to `xeocast-com`.
*   `custom_domain`: Defaults to `xeocast.com`.

You can override these defaults in your `.tfvars` file or via environment variables if needed.

## Usage

1.  **Initialize Terraform**:
    ```bash
    terraform init
    ```

2.  **Plan the changes** (Optional but recommended):
    ```bash
    terraform plan
    ```
    Review the planned actions before applying.

3.  **Apply the configuration**:
    ```bash
    terraform apply
    ```
    Confirm the action by typing `yes` when prompted.

## Destroying Resources

To remove the resources created by this configuration:

1.  **Run Terraform destroy**:
    ```bash
    terraform destroy
    ```
    Confirm the action by typing `yes` when prompted.

## GitHub Actions

A GitHub Actions workflow is included in `.github/workflows/terraform.yml`. This workflow automatically applies the Terraform configuration when changes are pushed to the `terraform` directory on the `main` branch.

**Secrets Required for GitHub Actions:**

*   `CLOUDFLARE_ACCOUNT_ID`: Your Cloudflare Account ID.
*   `CLOUDFLARE_API_TOKEN`: Your Cloudflare API Token.

Add these as secrets to your GitHub repository settings (`Settings > Secrets and variables > Actions`). 

**Note:** A second `git push` with some website changes is required to throw the deployment in the Cloudflare Pages project.