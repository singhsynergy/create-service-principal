# Create a Service Principal - Azure CLI

This topic shows you how to permit a service principal (such as an automated Azure CLI login process) to access other resources in your subscription.

A service principal contains the following credentials which will be mentioned in this page. Please store them in a secure location because they are sensitive credentials.

- **TENANT_ID**
- **CLIENT_ID**
- **CLIENT_SECRET** 

>**NOTE:** A service principal have two types: password-based and certificate-based. This topic only covers the password-based service principal.

# Create a Service Principal using Azure CLI 2.0

The easiest way to create the Service Principal is with the Azure CLI. You can [install Azure CLI 2.0](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) in the system of your preference.
