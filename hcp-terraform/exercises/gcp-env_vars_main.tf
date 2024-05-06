
/**** **** **** **** **** **** **** **** **** **** **** ****
 Add GOOGLE_CREDENTIALS to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "google_cloud_credentials" {
  key             = "GOOGLE_CREDENTIALS"
  value           = var.google_credentials
  category        = "env"
  description     = "Google Credentials"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add Google Cloud project ID to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "google_cloud_project" {
  key             = "project"
  value           = var.project
  category        = "terraform"
  description     = "Google Cloud project ID"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = false
}
