#!/usr/bin/env bash
set -o pipefail

# config parameters
 
BACKUP_DIR=$1
MYSQL_USR=$2
MYSQL_PWD=$3
MYSQL_HOST=$4
BACKUP_TYPE='<name>' # only define if you backup different server
BACKUP_FOLDER=backup_"$BACKUP_TYPE"_$(date +"%Y%m%d")
HOLD_DAYS=0
LOGFILE=<path>/logical_"$BACKUP_FOLDER".log

# functions

function CREATE_PIDFILE {
    
    # script run only once
    PIDFILE=/tmp/$0

    if [ -f "$PIDFILE" ] && kill -0 `cat $PIDFILE` 2>/dev/null; then
        echo $(date +"%F %T") "[ERROR] Another instance still running" | tee -a $LOGFILE
        exit 1
    fi  
    echo $$ > $PIDFILE

}

function CREATE_BACKUP_FOLDER {

    if [ ! -f "$BACKUP_DIR/$BACKUP_FOLDER.tar.gz" ]; then
        # create folder
        echo $(date +"%F %T") ": [INFO] Create backup directory" $BACKUP_DIR/$BACKUP_FOLDER | tee -a $LOGFILE
        mkdir $BACKUP_DIR/$BACKUP_FOLDER
    else
        # folder exists, then stop the whole process
        echo $(date +"%F %T") ": [ERROR] A backup exists! The process will stopped before files are deleted." | tee -a $LOGFILE
        echo $(date +"%F %T") ": [END] Backup process has been canceled!" | tee -a $LOGFILE
        REMOVE_PIDFILE
        REPORTING
        exit 1
    fi

}

function CREATE_DB_FOLDER {

    echo $(date +"%F %T") ": [INFO] Create schema folder" $BACKUP_DIR/$BACKUP_FOLDER/$db | tee -a $LOGFILE
    mkdir $BACKUP_DIR/$BACKUP_FOLDER/$db

}

function LIST_DATABASES {

    # remove 'Database' because we want only the schemas
    DATABASES=`mysql --user=$MYSQL_USR --password=$MYSQL_PWD --host=$MYSQL_HOST -e "SHOW DATABASES;" | grep -v "Database"`

}

function LIST_TABLES {

    # remove 'Tables_in_' because we want only the tables
    TABLES=`mysql --user=$MYSQL_USR --password=$MYSQL_PWD --host=$MYSQL_HOST -e "show tables from $db;" | grep -v "Tables_in_"`

}

function MYSQL_DUMP_TABLE {

    echo $(date +"%F %T") ": [INFO] Following table will be saved:" $table| tee -a $LOGFILE
    mysqldump --user=$MYSQL_USR --password=$MYSQL_PWD --host=$MYSQL_HOST --databases $db $table | gzip -c > $BACKUP_DIR/$BACKUP_FOLDER/$db/$table.sql.gz

}

function COMPRESS {

    echo $(date +"%F %T") ": [INFO] Compress the backup folder" $BACKUP_DIR/$BACKUP_FOLDER | tee -a $LOGFILE
    tar cfz $BACKUP_DIR/$BACKUP_FOLDER.tar.gz $BACKUP_DIR/$BACKUP_FOLDER
    echo $(date +"%F %T") ": [INFO] Remove uncompressed backup folder" $BACKUP_DIR/$BACKUP_FOLDER | tee -a $LOGFILE
    rm -rf $BACKUP_DIR/$BACKUP_FOLDER

}

function CLEANUP_OLD_BACKUP {
    
    # delete old backups (out of retention policy)
    find $BACKUP_DIR -type f -iname "*.tar.gz" -mtime +$HOLD_DAYS -delete
    echo $(date +"%F %T") ": [INFO] Old backups will be removed." | tee -a $LOGFILE
    echo $(date +"%F %T") ": [END] Backup process finished successfully!" | tee -a $LOGFILE

}

function REMOVE_PIDFILE {
    
    # pidfile will be removed
    rm $PIDFILE
 
}

function REPORTING {

    # date
    CREATION_DATE=$(date +%F)
    # duration
    # get timings
    START_TIME=$(cat $LOGFILE| grep -i '\[START\] ' | awk '{print $2}')
    END_TIME=$(cat $LOGFILE| grep -i '\[END\] ' | awk '{print $2}')
    # convert to seconds
    START_SEC=$(date -j -f '%H:%M:%S' $START_TIME '+%s')
    END_SEC=$(date -j -f '%H:%M:%S' $END_TIME '+%s')
    # calculate time difference
    TIME_DIFF=$(expr $END_SEC - $START_SEC)
    # convert to minutes / hours 
    USED_HOURS=$(expr $TIME_DIFF / 3600) # 1 h = 3600 s
    USED_MINUTES=$(expr $(expr $TIME_DIFF % 3600) / 60) # 1 m = 60 s
    USED_SECONDS=$(expr $TIME_DIFF % 60)
    # file size
    FILE_SIZE=$(ls -lah $BACKUP_DIR/$BACKUP_FOLDER.tar.gz | awk '{print $5}')
    # result
    RESULT=$(cat $LOGFILE | grep -i '\[END\] Backup process has been canceled!')
    
    if [ -z "$RESULT" ]; then
        echo "[Summary of backup process] Creation date:" $CREATION_DATE "Duration:" $USED_HOURS "h" $USED_MINUTES "min" $USED_SECONDS "sec Backup size:" $FILE_SIZE "Status: Successful" | tee -a $LOGFILE
    else
        echo "[Summary of backup process] Creation date:" $CREATION_DATE "Duration:" $USED_HOURS "h" $USED_MINUTES "min" $USED_SECONDS "sec Backup size:" $FILE_SIZE "Status: Failed" | tee -a $LOGFILE
    fi

}

# backup process
CREATE_PIDFILE
echo $(date +"%F %T") ": [START] Start the backup process..." | tee -a $LOGFILE
CREATE_BACKUP_FOLDER
LIST_DATABASES
echo $(date +"%F %T") ": [INFO] Following schemas will be saved:" $DATABASES| tee -a $LOGFILE
for db in $DATABASES; do
    CREATE_DB_FOLDER
    LIST_TABLES
    for table in $TABLES; do
        MYSQL_DUMP_TABLE
    done
done
COMPRESS
CLEANUP_OLD_BACKUP
REMOVE_PIDFILE
REPORTING