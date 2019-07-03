FROM centos:7

ENV MYSQL_REPO="https://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm"
RUN rpm -ivh ${MYSQL_REPO}

RUN yum install -y epel-release sudo vim fping telnet wget configure net-tools gcc make zlib-devel libffi-devel libxml2-devel net-snmp-devel libcurl-devel openssl openssl-devel crontabs libevent-devel mysql-devel mysql-community-client logrotate httpd php php-common php-pdo php-mbstring php-cli php-bcmath php-gd php-mysql php-xml mod_ssl php-ldap
RUN yum groupinstall 'Development Tools' -y

RUN yum update -y

RUN groupadd zabbix && \
    useradd -g zabbix zabbix