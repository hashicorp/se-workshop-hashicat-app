# Copyright (c) HashiCorp, Inc.

output "uuid" {
  value = random_uuid.id.*.result
}

output "name" {
  value = random_pet.pet
}

output "vending_machine_projects" {
  value = local.deployments
}

output "vending_machine_workspaces" {
  value = tfe_workspace.hashicat
}
