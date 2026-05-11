# Copyright IBM Corp. 2023, 2026


variable "google_credentials" {
  type      = string
  sensitive = true
}

variable "project" {
  type      = string
  sensitive = false
}
