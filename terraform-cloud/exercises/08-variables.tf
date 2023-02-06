# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


variable "oauth_connection_name" {
  type    = string
  default = "HashiCat Workshop"
}

variable "github_organization" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_token" {
  type = string
}
