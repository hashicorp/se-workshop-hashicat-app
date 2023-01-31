
/**** **** **** **** **** **** **** **** **** **** **** ****
 Add ARM_CLIENT_ID to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "azure_arm_client_id" {
  key             = "ARM_CLIENT_ID"
  value           = var.instruqt_azure_arm_client_id
  category        = "env"
  description     = "Azure Client ID"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add ARM_CLIENT_SECRET to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "azure_arm_client_secret" {
  key             = "ARM_CLIENT_SECRET"
  value           = var.instruqt_azure_arm_client_secret
  category        = "env"
  description     = "Azure Client Secret"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add ARM_SUBSCRIPTION_ID to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "azure_arm_subscription_id" {
  key             = "ARM_SUBSCRIPTION_ID"
  value           = var.instruqt_azure_arm_subscription_id
  category        = "env"
  description     = "Azure Subscription ID"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add ARM_TENANT_ID to the Cloud Credentials variable set
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_variable" "azure_arm_tenant_id" {
  key             = "ARM_TENANT_ID"
  value           = var.instruqt_azure_arm_tenant_id
  category        = "env"
  description     = "Azure Tenant ID"
  variable_set_id = tfe_variable_set.hashicat.id
  sensitive       = true
}
