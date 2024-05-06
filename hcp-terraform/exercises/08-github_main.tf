
/**** **** **** **** **** **** **** **** **** **** **** ****
 An OAuth Client represents the connection between an 
 organization and a VCS provider.
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_oauth_client" "github" {
  name             = var.oauth_connection_name
  organization     = data.tfe_organization.org.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_token
  service_provider = "github"
}
