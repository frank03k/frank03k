# Grafana-Reporter

![Docker](https://img.shields.io/badge/Docker-v19.03.13-blue) ![Grafana](https://img.shields.io/badge/Grafana-v7.2.0-orange) ![State](https://img.shields.io/badge/State-Ready--To--Deploy-green)

## Requirement

- mailing is possible (ssmtp, mail or exim4)
- Grafana is running on the same server
- ApiKey is available

## Deployment

- create directory

```
mkdir -p /opt/grafana-reporter/reports
```

- copy the docker-compose file in /opt/grafana-reporter

```
mv ~/docker-compose.yml /opt/grafana-reporter
```

- start container

```
cd /opt/grafana-reporter && docker-compose up -d
```

- copy the bash script to /opt/grafana-reporter
  - if necessary edit the timerange

```
mv ~/cron-report.sh /opt/grafana-reporter
```

- create a cronjob "/etc/cron.d/grafana-reporter" for the daily run

```
# daily report
0 0 * * *       root    bash /opt/grafana-reporter/cron-report.sh
 
# container is starting after server reboot
@reboot root docker-compose -f /opt/grafana-reporter/docker-compose.yml start | at now + 2 minutes
```
