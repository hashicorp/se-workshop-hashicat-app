
/**** **** **** **** **** **** **** **** **** **** **** ****
 Set up ADMINS team with the following permissions:

   * Manage policies 
   * Manage policy overrides
   * Workspaces
   * VCS settings
   * Run tasks
   * Private registry

**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team" "admins" {
  name         = "admins"
  organization = data.tfe_organization.org.name
  organization_access {
    manage_policies         = true
    manage_policy_overrides = true
    manage_workspaces       = true
    manage_vcs_settings     = true
    manage_run_tasks        = true
    manage_providers        = true // Allows members to publish and delete modules in the organization's private registry.
    manage_modules          = true // Allows members to publish and delete modules in the organization's private registry.
  }
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Set up DEVELOPERS team without any organization-wide access.
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team" "developers" {
  name         = "developers"
  organization = data.tfe_organization.org.name
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Set up MANAGERS team without any organization-wide access.
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team" "managers" {
  name         = "managers"
  organization = data.tfe_organization.org.name
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Associate the ADMINS team to permissions on the hashicat
 workspace with the ADMIN access grants. Admin permissions
 provide Full control of the workspace:

  * All permissions of write
  * Manage team access
  * Delete workspace
  * VCS configuration
  * Execution mode
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team_access" "admins" {
  access       = "admin"
  team_id      = tfe_team.admins.id
  workspace_id = tfe_workspace.hashicat.id
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Associate the DEVELOPERS team to permissions on the hashicat
 workspace with the WRITE access grants. Read permissions are:

  * All permissions of plan
  
    -- All permissions of read
    -- Create runs
    -- Add run comments

  * Can read and write
  * Approve runs
  * Lock/unlock workspace
  * Access to state
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team_access" "developers" {
  access       = "write"
  team_id      = tfe_team.developers.id
  workspace_id = tfe_workspace.hashicat.id
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Associate the MANAGERS team to permissions on the hashicat
 workspace with the READ access grants. Baseline permissions 
for reading a workspace are:

  * Read runs
  * Read variables
  * Read TF config versions
  * Read workspace information
  * Read state
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team_access" "managers" {
  access       = "read"
  team_id      = tfe_team.managers.id
  workspace_id = tfe_workspace.hashicat.id
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Invite LARS, AISHA and HIRO to the organization
**** **** **** **** **** **** **** **** **** **** **** ****/

locals {
  all_users = setunion(var.admins, var.developers, var.managers)
}

resource "tfe_organization_membership" "all_users" {
  for_each = local.all_users

  organization = data.tfe_organization.org.name
  email        = each.value
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add LARS to the ADMIN team - workshops+lars@hashicorp.com
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team_members" "admins" {
  team_id   = tfe_team.admins.id
  usernames = ["demo-lars"]
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add AISHA to the DEVELOPERS team - workshops+aisha@hashicorp.com
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team_members" "developers" {
  team_id   = tfe_team.developers.id
  usernames = ["demo-aisha"]
}

/**** **** **** **** **** **** **** **** **** **** **** ****
 Add HIRO to the MANAGERS - workshops+hiro@hashicorp.com
**** **** **** **** **** **** **** **** **** **** **** ****/

resource "tfe_team_members" "managers" {
  team_id   = tfe_team.managers.id
  usernames = ["demo-hiro"]
}
