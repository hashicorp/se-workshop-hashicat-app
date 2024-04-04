# Copyright (c) HashiCorp, Inc.

variable "tfc_organization" {
  type = string
}

variable "tfc_workspace" {
  type    = string
  default = "hashicat-aws"
}

variable "tfc_workspace_tags" {
  type    = list(any)
  default = ["hashicat", "CLOUD_ENV"]
}
