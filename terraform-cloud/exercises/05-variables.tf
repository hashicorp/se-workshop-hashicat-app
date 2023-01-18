# Copyright (c) HashiCorp, Inc.


variable "instruqt_aws_access_key_id" {
  type      = string
  sensitive = true
}

variable "instruqt_aws_secret_access_key" {
  type      = string
  sensitive = true
}

variable "prefix" {
  type = string
}

variable "region" {
  type = string
}
