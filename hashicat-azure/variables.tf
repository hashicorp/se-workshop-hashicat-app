##############################################################################
# Variables File
# 
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  description = "This prefix will be included in the name of most resources."

  validation {
    condition     = length(var.prefix) <= 58
    error_message = "Prefix must be at most 58 characters."
  }

  validation {
    condition     = can(regex("^([[:lower:]-[:digit:]])*$", var.prefix))
    error_message = "Prefix must include only lowercase alphanumeric characters, numbers and hyphen."
  }

  validation {
    condition     = can(regex("^[[:lower:]]", var.prefix))
    error_message = "Prefix must start with a letter."
  }

  # Our restrictions here are because var.prefix is used by azurerm_public_ip, which has the following restrictions:
  # domain_name_label must contain only lowercase alphanumeric characters, numbers and hyphens.
  # It must start with a letter, end only with a number or letter and not exceed 63 characters in length
  #
  # As we add the suffix "-meow" here, we only need to check:
  # Length (<= 58)
  # Characters
  # Start with letter
}

variable "location" {
  description = "The region where the virtual network is created."
  default     = "centralus"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_B1s"
}

variable "image_publisher" {
  description = "Name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "Name of the offer (az vm image list)"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  description = "Image SKU to apply (az vm image list)"
  default     = "22_04-LTS-gen2"
}

variable "image_version" {
  description = "Version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "Administrator user name for linux and mysql"
  default     = "hashicorp"
}

variable "admin_password" {
  description = "Administrator password for linux and mysql"
  default     = "Password123!"
}

variable "height" {
  default     = "400"
  description = "Image height in pixels."
}

variable "width" {
  default     = "600"
  description = "Image width in pixels."
}

variable "placeholder" {
  default     = "placekitten.com"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}
