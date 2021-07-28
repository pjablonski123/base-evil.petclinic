#!/bin/bash -l

./twistcli coderepo scan --address https://$PC_CONSOLE_URL -u $PC_USER -p $PC_PASS ./4scan 
echo result=$(curl -k -u $PC_USER:$PC_PASS -H 'Content-Type: application/json' "https://$PC_CONSOLE_URL/api/v1/coderepos-ci?limit=1&reverse=true&sort=scanTime")

if [ "$result" == "true" ]; then
   echo "Code Repo scan passed!"
   exit 0
else
   echo "Code Repo scan failed!"
   exit 1
fi

#|jq '.[0].pass'