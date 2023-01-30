
variable "admins" {
  type = list(string)
  default = [
    "workshops+lars@hashicorp.com"
  ]
}

variable "developers" {
  type = list(string)
  default = [
    "workshops+aisha@hashicorp.com"
  ]
}

variable "managers" {
  type = list(string)
  default = [
    "workshops+hiro@hashicorp.com"
  ]
}

variable "a" {
  default = [
    {
      name  = "demo-lars"
      email = "workshops+lars@hashicorp.com"
      team  = "admin"
    },
    {
      name  = "demo-aisha"
      email = "workshops+aisha@hashicorp.com"
      team  = "developers"
    },
    {
      name  = "demo-hiro"
      email = "workshops+hiro@hashicorp.com"
      team  = "managers"
    }
  ]
}
