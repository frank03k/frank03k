#!/bin/bash

SRCDB="$1";
DSTDB="$2";

### GET CONFORMATION
cat <<-EOF
Please check the parameters:
SOURCE-DATABASENAME:     "$SRCDB"
DESTINATION-DATABASENEM: "$DSTDB"
EOF

read -p "Ready or not [y/N]: " READY
if [[ "$READY" =~ [yY]([eE][sS])? ]]; then
        echo "Here we go!"
else
        echo "You can't hide. Exiting…"
        exit 0
fi

mysql -e "CREATE DATABASE $DSTDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

for i in $(mysql -Ns $SRCDB -e "show tables");do
    mysql -e "rename TABLE $SRCDB.$i to $DSTDB.$i"
    echo "$SRCDB.$i -> $DSTDB.$i"
done
