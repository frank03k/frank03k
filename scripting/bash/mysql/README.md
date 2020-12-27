# Introduction to MySQL

## Backup

### logical_backup.sh

- at the moment you can run the script with parameters from cli, but if you want then you can set the credentials in the first section of the script

```
# config parameters
 
BACKUP_DIR=$1
MYSQL_USR=$2
MYSQL_PWD=$3
MYSQL_HOST=$4
BACKUP_TYPE='<name>' # only define if you backup different server
BACKUP_FOLDER=backup_"$BACKUP_TYPE"_$(date +"%Y%m%d")
HOLD_DAYS=0
LOGFILE=<path>/logical_"$BACKUP_FOLDER".log
```

