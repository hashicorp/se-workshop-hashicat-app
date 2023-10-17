
variable "oauth_connection_name" {
  type    = string
  default = "HashiCat Workshop"
}

# Previously github_organization, but this argument was deprecated
variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_token" {
  type = string
}
