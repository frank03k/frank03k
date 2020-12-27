#!/usr/bin/env bash

set -Eeuo pipefail

DATABASES=($1)

for database in ${DATABASES[@]};do
        LOGFILE=./CHECKSUM_LOGFILE_"$database"_$(date +%F).log
        declare -a TABLES=$(mysql -e "SHOW TABLES FROM $database;" |grep -v 'Tables_in')
        for element in ${TABLES[@]}; do
                mysql -e "CHECKSUM TABLE $database.$element;" >> $LOGFILE
        done
done
