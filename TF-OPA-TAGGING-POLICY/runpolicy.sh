#!/bin/sh
terraform plan -out azurepolicy.plan
terraform show -json azurepolicy.plan > azurepolicy.json
opa eval --data plan.rego --input azurepolicy..json "data.azurepolicy.allow"
