 #!/usr/bin/env bash

 FQDN=$1
 REALM=$2
 BASE_DIR=$3

 echo "FQDN: ${FQDN}"
 echo "Realm: ${REALM}"
 echo "Basedir: ${BASE_DIR}"

 ipa-getcert request \
   -r \
   -f "${BASE_DIR}/${FQDN}.crt" \
   -k "${BASE_DIR}/${FQDN}.key" \
   -N "CN=${FQDN}" \
   -I "${FQDN}.request" \
   -K "host/${FQDN}@${REALM}" && \
   echo "Certs requested."
