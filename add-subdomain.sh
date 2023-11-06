#!/bin/bash
RG=rgrp-auora
DOMAIN=ipwatch.net
az login \
  --service-principal \
   --username "498e8a56-1027-4137-a182-75813f6ade33" \
   --password "919112ed-f1bd-4cb8-bc5d-04054d70b2f2" \
   --tenant "3efccf29-1384-4f0a-ad1a-70ba4d05bc80" >> /dev/null

read -r -p "Enter the Sub-domain name: " SUB_DOMAIN
read -r -p "Enter the IP_ADDRESS: " IP_ADDRESS
az network dns record-set a add-record -g $RG -z $DOMAIN -n $SUB_DOMAIN -a $IP_ADDRESS >> /dev/null
