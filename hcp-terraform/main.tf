# Copyright (c) HashiCorp, Inc.

terraform {
  required_providers {
    tfe = {
      version = "~> 0.38.0"
    }
  }
}

/**** **** **** **** **** **** **** **** **** **** **** ****
Obtain name of the target organization from the particpant.
**** **** **** **** **** **** **** **** **** **** **** ****/

data "tfe_organization" "org" {
  name = var.tf_organization
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Configure workspace with local execution mode so that plans 
 and applies occur on this workstation. And, HCP Terraform 
 is only used to store and synchronize state. 
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_workspace" "hashicat" {
  name           = var.tf_workspace
  organization   = data.tfe_organization.org.name
  tag_names      = var.tf_workspace_tags
  execution_mode = "local"
}
