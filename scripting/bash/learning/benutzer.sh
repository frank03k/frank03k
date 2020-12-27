#!/bin/bash
#Kursübung: Arbeiten mit Funktionen und exit
declare -r PASSWDFILE=/etc/passwd

die() {
	local nachricht="$1"
	local exitCode=$2
	echo "$nachricht"
	[ "$exitCode" == "" ] && exit 1 || exit $exitCode
}

existiert_user() {
	local u=$1
	grep -qEw "^$u" $PASSWDFILE && die "Username $u existier bereits" 1
}

ist_root_user() {

	[ "$(id -u)" != "0" ] && die "Sie sind nicht der Root User" 2 
}

user_hinzufuegen() {
echo "/sbin/useradd -s /sbin/bash -m $1"
echo "Der Benutzer: $1 wurde angelegt"
}

ist_root_user
existiert_user $1
user_hinzufuegen $1
