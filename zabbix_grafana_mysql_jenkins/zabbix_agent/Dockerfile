FROM centos:7

RUN yum -y install sudo vim fping telnet configure net-tools gcc make libxml2-devel net-snmp-devel libcurl-devel openssl-devel crontabs libevent-devel

RUN groupadd zabbix && \
    useradd -g zabbix zabbix

COPY files/ /zbx/
RUN chmod 777 -R /zbx/
WORKDIR /zbx/zabbix_install
RUN ./configure --prefix=/usr/local/zabbix --enable-agent && \
    touch configure.ac aclocal.m4 configure Makefile.am Makefile.in && \
    make install
RUN mv /usr/local/zabbix/etc/zabbix_agentd.conf /usr/local/zabbix/etc/zabbix_agentd_original.conf && \
    cp /zbx/zabbix_agentd.conf /usr/local/zabbix/etc/zabbix_agentd.conf && \
    chmod -R 777 /usr/local/zabbix/*

USER root
RUN cp /zbx/sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers

RUN chown zabbix.zabbix /zbx/init.sh && \
    chmod 777 /zbx/init.sh
ENTRYPOINT ["sh","/zbx/init.sh"]
USER zabbix
WORKDIR /zbx