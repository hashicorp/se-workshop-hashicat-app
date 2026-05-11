# Copyright IBM Corp. 2023, 2026


variable "oauth_connection_name" {
  type    = string
  default = "HashiCat Workshop"
}

variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_token" {
  type = string
}
