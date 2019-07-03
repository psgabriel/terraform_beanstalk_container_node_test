FROM centos:7

RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
COPY files/zabbix.conf /etc/httpd/conf/zabbix.conf
COPY files/php.ini /etc/php.ini

COPY files/frontend/ /var/www/html/
COPY files/zabbix.conf.php /var/www/html/conf/zabbix.conf.php
RUN chown -R apache.apache /var/www/html/ && \
    chmod -R 777 /var/www/html/

COPY files/init.sh /zbx/
RUN chmod 777 /zbx/init.sh
ENTRYPOINT ["sh","/zbx/init.sh"]
EXPOSE 80
WORKDIR /