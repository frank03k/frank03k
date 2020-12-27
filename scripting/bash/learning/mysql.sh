#!/bin/bash
#Kursübung: MySQL Backup Skript: Simple & Effektiv

TIMESTAMP=$( date +%F )
BACKUP_DIR="/tmp/backup/$TIMESTAMP"

mkdir -p $BACKUP_DIR

databases=$(mysql --login-path=local -Bse "SHOW DATABASES" | grep -Ev "(information_schema|performance_schema)")

for db in $databases
do
mysqldump --login-path=local $db | gzip > "$BACKUP_DIR/$db.gz"
echo "Backup erstellen für $db"
done
