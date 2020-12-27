#!/bin/bash
#Kursübung: IP Adresse einer Domain anzeigen

read -p "Bitte gib den Domainnamen an: " domainname

echo "Die Domain $domainname hat die IP Adresse:"
host $domainname | grep "has address" | awk '{print $4}'
