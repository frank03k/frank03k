#!/usr/bin/env bash
# variables:
# ----------
GRAFANA_URL="localhost"
GRAFANA_PORT="3000"
APIKEY="--"
DASHBOARDID="--"
TIMERANGE="now-24h"
FILE=/mnt/grafana-reporter/report_$(date +%F).pdf
RECIPIENT=reporting@ewerk.com

# process:
# --------
# detect current docker id
DOCKERID=$(docker ps | grep grafana-reporter | awk '{print $1}')

# create report
RUN="grafana-reporter -cmd_enable=1 -cmd_apiKey $APIKEY -ip $GRAFANA_URL:$GRAFANA_PORT -cmd_dashboard $DASHBOARDID -cmd_ts from=$TIMERANGE -cmd_o $FILE"
docker exec -it $DOCKERID $RUN

# mail report
mail -s "[REPORT] Grafana Dashboard" -A /opt/grafana-reporter/reports/report_$(date +%F).pdf  $RECIPIENT < /dev/null
