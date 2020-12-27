#!/bin/bash
# requirement: root user credentials deposited in .my.cnf
# alternative statement:
# mysql -u $USER -p $PASSWORD -e

LOGFILE=/tmp/mysql_privs.log #to be define

# list all database user

mysql -e "select user,host from mysql.user;" > /tmp/mysql_user_export.txt

# fill array with all user

declare -a LISTARRAY=( $(cat /tmp/mysql_user_export.txt | awk '{print "\047"$1"\047@\047"$2"\047"}') )

# loop to get db privileges

for user_host in ${LISTARRAY[@]}; do
        #echo $user_host #Debugging
        mysql -e "show grants for $user_host;" >> $LOGFILE
        echo $'\n' >> $LOGFILE
done
