#!/bin/bash

read -r -p "Enter the App Display Name: " app_display_name
read -r -p "Enter the Azure subscription_id: " subscription_id
app_display_name="$app_display_name"
subscription_id="$subscription_id"
az login
az account set -s "${subscription_id}"
az ad app create --display-name "${app_display_name}" > Credentials.txt
app_obj_id=$( \
  az ad app list \
    --display-name "${app_display_name}" \
    --query [].id \
    --output tsv
)
az ad sp create --id "${app_obj_id}"
spn_app_id=$( \
  az ad sp list \
    --display-name "${app_display_name}" \
    --query [].appId \
    --output tsv
)
az ad sp credential reset --id "${spn_app_id}"
spn_obj_id=$( \
  az ad sp list \
    --display-name "${app_display_name}" \
    --query [].id \
    --output tsv
)
tenant_id=$( \
  az ad sp list \
    --display-name "${app_display_name}" \
    --query [].appOwnerOrganizationId \
    --output tsv
)
az role assignment create \
  --assignee-object-id "${spn_obj_id}" \
  --assignee-principal-type "ServicePrincipal" \
  --role "Contributor" \
  --scope "/subscriptions/${subscription_id}"

cat Credentials.txt
