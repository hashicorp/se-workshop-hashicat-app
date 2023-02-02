# Copyright (c) HashiCorp, Inc.

policy "enforce-mandatory-tags" {
    enforcement_level = "soft-mandatory"
}

policy "restrict-deployment-cost" {
    enforcement_level = "soft-mandatory"
}

# policy "enforce-trusted-modules" {
#    enforcement_level = "advisory"
# }

module "tfplan-functions" {
  source = "https://raw.githubusercontent.com/hashicorp/terraform-sentinel-policies/main/common-functions/tfplan-functions/tfplan-functions.sentinel"
}

module "azure-functions" {
  source = "https://raw.githubusercontent.com/interrupt-software/terraform-sentinel-policies/main/azure/azure-functions/azure-functions.sentinel"
}
