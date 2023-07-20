variable "primary_region" {
  type    = string
  default = "westeurope"
}

variable "dr_region" {
  type    = string
  default = "northeurope"
}

variable "resource_group_count" {
  type    = number
  default = 5
}

variable "resource_group_names_subscription_a" {
  type = list(string)
  default = [
    "rg-subscription-a-1",
    "rg-subscription-a-2",
    "rg-subscription-a-3",
    "rg-subscription-a-4",
    "rg-subscription-a-5"
  ]
}

variable "subscription_a_id" {
  type    = string
  default = ""
}

