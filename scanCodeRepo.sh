#!/bin/bash

./twistcli coderepo scan --address https://$PC_CONSOLE_URL -u $PC_USER -p $PC_PASS ./4scan 

result=$(curl -k -u $PC_USER:$PC_PASS -H 'Content-Type: application/json' "https://$PC_CONSOLE_URL/api/v1/coderepos-ci?limit=1&reverse=true&sort=scanTime" | jq '.[0].vulnInfo.vulnerabilityDistribution | {critical,high}')
#sum=$(jq -n '[inputs.critical] | add' <<< $(echo ${result/high/critical}))
critical=$(echo $result | jq -n '[inputs.critical] | add')
high=$(echo $result | jq -n '[inputs.high] | add')

if [ [$critical=0] && [$high=0] ]; then
   echo "Code Repo scan passed!"
   exit 0
else
   echo "Code Repo scan failed - $critical Critical and $high High alerts!"
   exit 1
fi
