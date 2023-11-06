#!/bin/bash
RG=<Azure RG>
## Domain name like abc.com
DOMAIN=<fully qualified Domain Name>
az login \
  --service-principal \
   --username "${spn_app_id}" \
   --password "<your_service_principal_password>" \
   --tenant "${tenant_id}" >> /dev/null


read -r -p "Enter only Sub-domain name. for example, if you want to create a subdomain test.abc.com then just type test: " SUB_DOMAIN
read -r -p "Enter the IP_ADDRESS on which you want to bind the sub-domain: " IP_ADDRESS
az network dns record-set a add-record -g $RG -z $DOMAIN -n $SUB_DOMAIN -a $IP_ADDRESS >> /dev/null
