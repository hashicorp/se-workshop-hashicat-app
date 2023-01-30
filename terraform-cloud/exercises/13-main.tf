
/**** **** **** **** **** **** **** **** **** **** **** ****
 Specifies the Terraform provider for our deployment. 
 For example, "aws_s3"
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_registry_module" "aws-s3-bucket" {
  vcs_repo {
    display_identifier = "${var.github_organization}/${var.module_repo}"
    identifier         = "${var.github_organization}/${var.module_repo}"
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
  }
}
