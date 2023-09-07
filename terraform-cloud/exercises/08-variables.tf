
variable "oauth_connection_name" {
  type    = string
  default = "HashiCat Workshop"
}

// previously github_organizaition but this argument is deprecated
variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_token" {
  type = string
}
