#!/bin/bash
# Process:
# - detect all schemas (exclude mysql, sys, information and performance)
# - detect all views of each schema
# - export views

# -- detect all schemas --
# create export directory
mkdir -p /tmp/db_export
# get list of all schemas
mysql -e "show schemas;" > /tmp/db_export/schemas.txt
# use only the application databases
declare -a SCHEMA=( $(cat /tmp/db_export/schemas.txt | grep -v 'mysql' | grep -v 'Database'| grep -v 'sys'| grep -v 'information_schema'| grep -v 'performance_schema'))
# loop to get information about the VIEWS
for DATABASE in ${SCHEMA[@]}; do
    mysql -e "SHOW FULL TABLES IN $DATABASE WHERE table_type='VIEW';" | grep -v 'Tables_in'> /tmp/db_export/database.$DATABASE.txt
done

# -- detect all views --
# get information for each VIEW in Database-Export-File
declare -a FILELIST=( $())
for FILE in ${FILELIST[@]}; do


#Note
#ls -1 /tmp/db_export|grep "database" |awk -F "." '{print $2}'
