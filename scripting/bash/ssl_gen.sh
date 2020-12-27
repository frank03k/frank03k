# generate
openssl req -newkey rsa:4096 -sha256 -keyout ${1}.key -out ${1}.csr
# remove passphrase
openssl rsa -in ${1}.key -out ${1}.nopass.key
# verify
openssl req -text -noout -verify -in ${1}.csr
