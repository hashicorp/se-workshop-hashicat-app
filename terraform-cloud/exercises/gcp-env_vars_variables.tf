# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


variable "google_credentials" {
  type      = string
  sensitive = true
}

variable "project" {
  type      = string
  sensitive = false
}
