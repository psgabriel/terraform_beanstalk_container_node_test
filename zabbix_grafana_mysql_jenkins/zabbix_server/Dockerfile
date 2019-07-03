FROM psgabriel/centos_custom::1.0

COPY files/ /zbx/
WORKDIR /zbx/zabbix_install
RUN chmod 777 -R /zbx/zabbix_install

RUN ./configure --prefix=/usr/local/zabbix --enable-server --with-net-snmp --with-mysql --with-libcurl --with-libxml2 --with-openssl && \
    touch configure.ac aclocal.m4 configure Makefile.am Makefile.in && \
    make install

ENV ZABBIX_REPO="https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm"
RUN rpm -ivh ${ZABBIX_REPO}

RUN yum install zabbix-get -y
RUN cp /usr/bin/zabbix_get /usr/local/zabbix/sbin/zabbix_get && \
    chmod -R 777 /usr/local/zabbix/*

COPY ./files/zabbix_scripts /zbx_scripts
RUN chmod 777 -R /zbx_scripts/
RUN chown zabbix.zabbix /zbx_scripts/

RUN cp /zbx/sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers

COPY ./files/zabbix_server.conf /usr/local/zabbix/etc/zabbix_server.conf
RUN chown zabbix.zabbix /zbx/init.sh && \
    chmod 777 /zbx/init.sh
ENTRYPOINT ["sh","/zbx/init.sh"]
USER zabbix
WORKDIR /
EXPOSE 10051