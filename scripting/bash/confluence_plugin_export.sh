#!/bin/bash
# requirements:
# - jq have to installed
#

CONFLUENCE_SERVER_URL="<URL>"
CONFLUENCE_SERVER_CONTEXT_PATH=""
ADMIN_USRNAME=<USER>
ADMIN_PWD=<PASSWORD>


CONFLUENCE_BASE_URL=$CONFLUENCE_SERVER_URL$CONFLUENCE_SERVER_CONTEXT_PATH
curl --user $ADMIN_USRNAME:$ADMIN_PWD $CONFLUENCE_BASE_URL/rest/plugins/latest/ 2>/dev/null | jq -r '.plugins[] | select(.userInstalled) | "\(.name):\(.version):\(.vendor.name):\(.usesLicensing):\(.links.self)"' > /tmp/restapi_prod.out
echo "Plugin Name:Plugin Version:Vendor Name:Use License:License Type:Expiry Date:License Key:SEN" > /tmp/PluginReport_Prod.csv
while read PLUGINLINE; do
PLUGINKEY=$(awk 'BEGIN { FS=":" } { print $5 }' <<< "$PLUGINLINE")
LICINFO=$(curl --user $ADMIN_USRNAME:$ADMIN_PWD $CONFLUENCE_SERVER_URL$PLUGINKEY/license/ 2>/dev/null | jq '"\(.licenseType):\(.maintenanceExpiryDateString):\(.rawLicense):\(.supportEntitlementNumber)"' | sed -e 's/^"//' -e 's/"$//')
PLGINFO=$(awk 'BEGIN { FS=":"; OFS=":"; } { print $1,$2,$3,$4 }' <<< "$PLUGINLINE")
echo "$PLGINFO:$LICINFO"
done < /tmp/restapi_prod.out >> /tmp/PluginReport_Prod.csv
