
/**** **** **** **** **** **** **** **** **** **** **** ****
 Specifies the Terraform provider for our deployment. 
 For example: "aws_s3", "Azure Blob Storage", or "Google Cloud
 Storage" modules in the public Terraform Registry.
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_registry_module" "STORAGE_MODULE" {
  vcs_repo {
    display_identifier = "${var.github_organization}/${var.module_repo}"
    identifier         = "${var.github_organization}/${var.module_repo}"
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
  }
}
