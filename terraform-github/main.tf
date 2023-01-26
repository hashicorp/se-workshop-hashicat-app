# Copyright (c) HashiCorp, Inc.

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "github" {}

resource "github_repository" "hashicat" {
  name        = var.github_repo_name
  description = "HaschiCat App is a social app for felines of all kinds."

  visibility = "public"
}

output "repo_url" {
  value = github_repository.hashicat.html_url
}
