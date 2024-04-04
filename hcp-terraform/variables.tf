# Copyright (c) HashiCorp, Inc.

variable "tf_organization" {
  type = string
}

variable "tf_workspace" {
  type    = string
  default = "hashicat-aws"
}

variable "tf_workspace_tags" {
  type    = list(any)
  default = ["hashicat", "CLOUD_ENV"]
}
