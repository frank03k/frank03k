#!/bin/bash

# parameters
# fix values
DATETIME=$(date +%F)
TEMPFILE=/tmp/reportlog_$DATETIME.txt
LASTMONTH=$(date +%Y%m --date "last month")
declare -a LOGICAL_BACKUP=(NOM_DAILY NOM_WEEKLY MAIN_DAILY MAIN_WEEKLY)
declare -a HOT_BACKUP=(NOM_MONTHLY MAIN_MONTHLY)
PATH_MONTHLY_BACKUPS=/backups/hot_backups/
PATH_DAILY_AND_WEEKLY_BACKUP=/backups/logical_backups/

# process
# create tmp-report logfile
touch $TEMPFILE

# all information to report logfile
# logical backup
for BACKUPSET in ${LOGICAL_BACKUP[@]}; do 
    echo $BACKUPSET >> $TEMPFILE
    cat "$PATH_DAILY_AND_WEEKLY_BACKUP"logical_backup_"$BACKUPSET"_"$LASTMONTH"* |grep "Summary" >> $TEMPFILE
done

# hot backup
for BACKUPSET in ${HOT_BACKUP[@]}; do 
    echo $BACKUPSET >> $TEMPFILE
    cat "$PATH_MONTHLY_BACKUPS"hot_backup_"$BACKUPSET"_"$LASTMONTH"* |grep "Summary" >> $TEMPFILE
done
