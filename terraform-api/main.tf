# Copyright (c) HashiCorp, Inc.

terraform {
  required_providers {
    tfe = {
      version = "~> 0.40.0"
    }
  }
}

locals {
  deployments = jsondecode(file("${path.module}/list_of_deployments.json"))
}

/**** **** **** **** **** **** **** **** **** **** **** ****
Obtain name of the target organization from the particpant.
**** **** **** **** **** **** **** **** **** **** **** ****/

data "tfe_organization" "org" {
  name = var.tfc_organization
}

resource "random_uuid" "id" {
  count = length(local.deployments)
}

resource "random_pet" "pet" {
  length = 3
  count  = length(local.deployments)
}

resource "tfe_project" "hashicat" {
  organization = data.tfe_organization.org.name
  name         = "Vending_Macheen"
}

# /**** **** **** **** **** **** **** **** **** **** **** ****
#  Configure workspace with remote execution mode so that plans 
#  and applies occur on the Terraform Cloud platform via API.
# **** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_workspace" "hashicat" {
  count        = length(random_pet.pet)
  name         = random_pet.pet[count.index].id
  organization = data.tfe_organization.org.name
  project_id   = tfe_project.hashicat.id
  description  = local.deployments[count.index].Description
  tag_names = [
    local.deployments[count.index]["Deployment ID"],
    local.deployments[count.index]["Department"],
    local.deployments[count.index]["Product Stack"],
    local.deployments[count.index]["Environment"]
  ]
}
