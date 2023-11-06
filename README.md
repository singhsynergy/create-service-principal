# Create a Service Principal - Azure CLI

This topic shows you how to permit a service principal (such as an automated Azure CLI login process) to access other resources in your subscription.

A service principal contains the following credentials which will be mentioned in this page. Please store them in a secure location because they are sensitive credentials.

- **TENANT_ID**
- **CLIENT_ID**
- **CLIENT_SECRET** 

>**NOTE:** A service principal have two types: password-based and certificate-based. This topic only covers the password-based service principal.

# 1 Create a Service Principal using Azure CLI

The easiest way to create the Service Principal is with the Azure CLI. You can [install Azure CLI 2.0](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) in the system of your preference.

## 1.1 Install and Configure Azure CLI

Install and configure Azure CLI following the documentation [**HERE**](http://azure.microsoft.com/en-us/documentation/articles/xplat-cli/).

## 1.2 Login to Azure Account

```
azure login 
```

>**NOTE:**
  * `azure login` requires a work or school account. Never login with your personal account. If you do not have a work or school account currently, you can easily create a work or school account with the [**guide**](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-connect/).

# 2 Create a Service Principal

Azure CPI provisions resources in Azure using the Azure Resource Manager (ARM) APIs. We use a Service Principal account to give Azure CPI the access to proper resources.

## 2.1 Via Script (RECOMMENDED)

### 2.1.1 Clone the Repository on your server
```
apt install git 
git clone git@github.com:jassi-devops/create-service-principal.git
```

### 2.1.2 Give the execute permission to Scipt create-service-account.sh
```
cd create-service-principal
chmod +x create-service-account.sh
```

### 2.1.3 Run the script to generate your Service Principal
```
sh create-service-account.sh
```

## 2.2 Manually

### 2.2.1 Add Varibale Value
```
pp_display_name="test-serviceprinciple"
subscription_id="<>"
```
### 2.2.2 Create application in Azure APP Registration
```
az ad app create --display-name "${app_display_name}"
```
### 2.2.3 Get the Object ID and save it in the Variable
```
app_obj_id=$( \
  az ad app list \
    --display-name "${app_display_name}" \
    --query [].objectId \
    --output tsv
)
```
### 2.2.4 Create Service Principle in Azure APP Registration
```
az ad sp create --id "${app_obj_id}"
```
### 2.2.5 Get the SP App ID and save it in the Variable
```
spn_app_id=$( \
  az ad sp list \
    --display-name "${app_display_name}" \
    --query [].appId \
    --output tsv
)
```
### 2.2.6 Get the SP Credentials like(Object ID, Tenant ID and password)
```
az ad sp credential reset --name "${spn_app_id}"
```
### 2.2.7 Get the SP Object ID and save it in the Variable
```
spn_obj_id=$( \
  az ad sp list \
    --display-name "${app_display_name}" \
    --query [].objectId \
    --output tsv
)
```
### 2.2.8 Get the Tenant ID and save it in the Variable
```
tenant_id=$( \
  az ad sp list \
    --display-name "${app_display_name}" \
    --query [].appOwnerTenantId \
    --output tsv
)
```
### 2.2.9 Create the Contributor role and assign it to ServicePrincipal
```
az role assignment create \
  --assignee-object-id "${spn_obj_id}" \
  --assignee-principal-type "ServicePrincipal" \
  --role "Contributor" \
  --scope "/subscriptions/${subscription_id}"
```
### 2.2.10 Test the newly created service principal as follows:
```
az logout
az login \
  --service-principal \
   --username "${spn_app_id}" \
   --password "<your_service_principal_password>" \
   --tenant "${tenant_id}"
```
