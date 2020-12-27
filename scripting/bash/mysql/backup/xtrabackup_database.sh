#!/bin/bash

# variables
datadir="<path>"
targetdir="<path>/backup_$(date +'%Y-%m-%d')"
logfile="<path>/xtrabackup_$(date +'%Y-%m-%d').log"

# create backup directory
mkdir $targetdir
# create backup
xtrabackup --backup --target-dir=$targetdir --datadir=$datadir 2> $logfile
# prepare the backup before restore tasks
xtrabackup --prepare --target-dir=$targetdir
# compress backup directory
tar cfvz "$targetdir".tar.gz $targetdir
# remove uncompressed backup directory
rm -rf $targetdir
# remove old logfiles (older than 14 days)
find /backup/confluence/ -iname '*.log' -mtime +14 -delete
find /backup/confluence/ -iname '*.tar.gz' -mtime +14 -delete
