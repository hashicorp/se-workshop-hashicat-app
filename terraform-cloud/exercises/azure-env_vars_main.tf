
/**** **** **** **** **** **** **** **** **** **** **** ****
 Add AWS_ACCESS_KEY_ID to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "aws_access_key_id" {
  key             = "AWS_ACCESS_KEY_ID"
  value           = var.instruqt_aws_access_key_id
  category        = "env"
  description     = "AWS access key"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add AWS_SECRET_ACCESS_KEY to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "aws_secret_access_key" {
  key             = "AWS_SECRET_ACCESS_KEY"
  value           = var.instruqt_aws_secret_access_key
  category        = "env"
  description     = "AWS secret key"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}
