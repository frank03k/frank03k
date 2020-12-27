#!/bin/bash

# parameters
# fix values
DATETIME=$(date +%F)
REMOTE_TEMPFILE=/tmp/reportlog_$DATETIME.txt
declare -a BACKUPSERVER=(server1 server2 server3)
SSHKEY=---
SSHUSER=---
RECIPIENT=---

# process
# pull tmp-report logfile to localhost
for server in ${BACKUPSERVER[@]}; do
	scp -i $SSHKEY $SSHUSER@$server:$REMOTE_TEMPFILE /tmp/
	mv /tmp/reportlog_$DATETIME.txt /tmp/reportlog_"$server"_"$DATETIME".txt
	mail -s "[REPORTING] SMSS DB BACKUP" -A/tmp/reportlog_"$server"_"$DATETIME".txt $RECIPIENT < /dev/null
done

# remove tmp-report
rm /tmp/reportlog_*
