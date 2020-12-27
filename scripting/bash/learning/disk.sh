#!/bin/bash
#Kursübung: Email Benachrichtigung wenn Harddisk Speicher voll ist

EMAILTO="root@localhost"
LIMITHDD=0

df -H | grep -vE '^Dateisystem|tmpfs' | awk '{ print $5 " " $1 }' | while read output;
do
limit=$(echo $output | awk '{ print $1 }' | cut -d'%' -f1 )
partition=$(echo $output | awk ' { print $2 }' )

if [ $limit -ge $LIMITHDD ]
then
	echo "Der Festplattenspeicher der Partition $partition auf dem Host $(hostname) geht zuende mit $limit % belegt am $(date)" 
# | mail -s "ACHTUNG: SPEICHER GEHT ZUENDE" $EMAILTO
fi
done
