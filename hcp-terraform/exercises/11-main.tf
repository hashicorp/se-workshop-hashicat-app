
/**** **** **** **** **** **** **** **** **** **** **** ****
 Add a collection of policies to enhance the governance rules
 to support business rules and security guidelines.
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_policy_set" "test" {
  name          = "Hashicat-Social"
  description   = "Policies for HashiCat Social"
  organization  = data.tfe_organization.org.name
  policies_path = "/policies"
  workspace_ids = [tfe_workspace.hashicat.id]

  vcs_repo {
    identifier         = "${var.github_owner}/${var.github_repo}"
    branch             = "main"
    ingress_submodules = false
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
  }
}
