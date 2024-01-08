# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


variable "instruqt_azure_arm_client_id" {
  type      = string
  sensitive = true
}

variable "instruqt_azure_arm_client_secret" {
  type      = string
  sensitive = true
}

variable "instruqt_azure_arm_subscription_id" {
  type      = string
  sensitive = true
}

variable "instruqt_azure_arm_tenant_id" {
  type      = string
  sensitive = true
}
