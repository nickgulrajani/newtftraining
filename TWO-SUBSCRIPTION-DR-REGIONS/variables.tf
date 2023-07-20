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
  type    = list(string)
  default = [
    "rg-subscription-a-1",
    "rg-subscription-a-2",
    "rg-subscription-a-3",
    "rg-subscription-a-4",
    "rg-subscription-a-5"
  ]
}

variable "resource_group_names_subscription_b" {
  type    = list(string)
  default = [
    "rg-subscription-b-1",
    "rg-subscription-b-2",
    "rg-subscription-b-3",
    "rg-subscription-b-4",
    "rg-subscription-b-5"
  ]
}

variable "subscription_a_id" {
  type    = string
  default = ""
}

variable "subscription_b_id" {
  type    = string
  default = "YOUR_SUBSCRIPTION_B_ID"
}

