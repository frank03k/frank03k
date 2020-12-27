#!/bin/bash
#----------------------------------------------------------------------------------
# Wrapper for mysql replication delay check.
#----------------------------------------------------------------------------------
# params: [-w <warn>] [-c <crit>] [-m <daysofmonth>] [-d <daysofweek>] [-h <hours]
#----------------------------------------------------------------------------------
# -w warning threshold
# -c critical threshold
# -m day of month for threshold adjustment <1-31>
# -d day of week for threshold adjustment <0-6, sunday to saturday>
# -h hours for threshold adjustment <0-23>
#
# Day(s) of month or day(s) of week MUST BE combined with hour(s)!
#
# e.g. -m "1" -h "02 03 04" : first day of month between 2 and 5 am.
# e.g. -d "0 1" -h "16"  : sunday and monday between 16 and 17 pm.
#----------------------------------------------------------------------------------
# @author: Mirko Schlothauer <m.schlothauer@ewerk.com>
# @date: 2018/01/26
#----------------------------------------------------------------------------------
# default warning threshold
WARN_DEF=1200
# default critical threshold
CRIT_DEF=2400
# exception flag for current day
DAY_EXC=0
# exception flag for current hour
HOUR_EXC=0
THIS_DAYOFWEEK=$(date +%w)
THIS_HOUR=$(date +%H)
THIS_DAYOFMONTH=$(date +%e)
while getopts w:c:d:m:h: opt
do
   case $opt in
       w) WARN=$OPTARG;;
       c) CRIT=$OPTARG;;
       d) DAYSOFWEEK=$OPTARG;;
       m) DAYSOFMONTH=$OPTARG;;
       h) HOURS=$OPTARG;;
   esac
done
# is the current day of week affected?
for i in $DAYSOFWEEK; do
    if [ "$THIS_DAYOFWEEK" == "$i" ]; then
        DAY_EXC=1
    fi
done
# is the current day of month affected?
for i in $DAYSOFMONTH; do
    if [ "$THIS_DAYOFMONTH" == "$i" ]; then
        DAY_EXC=1
    fi
done
# are we currently in the defined timerange?
for i in $HOURS; do
    if [ "$THIS_HOUR" == "$i" ]; then
        HOUR_EXC=1
    fi
done
if  [ "$DAY_EXC" == "1" ] && [ "$HOUR_EXC" == "1" ]; then
    APPENDIX="Check runs in a special defined time range. Thresholds are adjusted to $WARN (w) and $CRIT(c)."
else
    APPENDIX=""
    WARN=$WARN_DEF
    CRIT=$CRIT_DEF
fi
OUTPUT=$(/usr/lib/nagios/plugins/pmp-check-mysql-replication-delay -w $WARN -c $CRIT --defaults-file /var/lib/nagios/.my.cnf);
RET=$?
if [ -z "$OUTPUT" ]; then
    OUTPUT="No output received by check."
    RET=3
fi
echo -e "$OUTPUT $APPENDIX"
exit "$RET"
