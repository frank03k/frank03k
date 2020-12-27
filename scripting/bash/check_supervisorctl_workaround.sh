#!/bin/bash
# --
# Checks supervisorctl for programs that are not in the state of RUNNING.
# That is to say STOPPED, STARTING, BACKOFF, STOPPING, EXITED, FATAL, UNKNOWN
#

# --------------------------------------------------------------------
# configuration
# --------------------------------------------------------------------
PROGNAME=$(basename $0)
ERR_MESG=()
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"
LIBEXEC="/usr/lib/nagios/plugins"
. $LIBEXEC/utils.sh

# exlcude special task/job -> workaround
JOB="transfer_sas_in_SEMOPX"

# --------------------------------------------------------------------
# functions
# --------------------------------------------------------------------

function print_help() {
        echo ""
        echo "Checks supervisorctl to see if all programs are running."
        echo ""
        echo "This plugin is NOT developped by the Nagios Plugin group."
        echo "Please do not e-mail them for support on this plugin, since"
        echo "they won't know what you're talking about."
        echo ""
        echo "For contact info, read the plugin itself..."
}
function check_supervisor(){
        check_command=$(supervisorctl status | egrep '(BACKOFF)|(FATAL)|(UNKNOWN)' | egrep -v '$JOB' | wc -l)
        if (( $check_command != 0 )); then
                echo "One or more of your programs are not running!"
                exit $STATE_CRITICAL
        else
                echo "OK: All of your programs are running!"
                exit $STATE_OK
        fi
}

function check_supervisor_deamon(){
        check_command=$(systemctl status supervisor | grep 'active (running)' | wc -l)
        if (( $check_command != 1 )); then
                echo "supervisor deamon ist not running"
                exit $STATE_CRITICAL
        fi
}

# --------------------------------------------------------------------
# startup checks
# --------------------------------------------------------------------

if [ $# -eq 0 ]; then
        check_supervisor_deamon
        check_supervisor
fi

while [ "$1" != "" ]
do
        case "$1" in
                --help) print_help; exit $STATE_OK;;
                -h) print_help; exit $STATE_OK;;
        esac
