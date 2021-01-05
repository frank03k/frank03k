#!/usr/bin/env bash -euo
# This script is created and tested for CentOS 8.
# Run this script as root.

javapkg=java-1.8.0-openjdk-headless.x86_64
mongodb_repoblock=
elastic_url=https://artifacts.elastic.co/GPG-KEY-elasticsearch
elastic_repoblock=
graylog_url=https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.rpm

# install necessary java packages 
sudo yum install $javapkg
sudo yum install epel-release
sudo yum install pwgen

# install database (mongodb)
cat << 'EOF' > /etc/yum.repos.d/mongodb-org.repo
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
EOF
sudo yum install mongodb-org
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl start mongod.service

# install and configure elastivsearch
rpm --import $elastic_url
cat << 'EOF' > /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/oss-7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF
sudo yum install elasticsearch-oss
sudo tee -a /etc/elasticsearch/elasticsearch.yml > /dev/null <<EOT
cluster.name: graylog
action.auto_create_index: false
EOT
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl restart elasticsearch.service

# install graylog
sudo rpm -Uvh $graylog_url
sudo yum update
sudo yum install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service
