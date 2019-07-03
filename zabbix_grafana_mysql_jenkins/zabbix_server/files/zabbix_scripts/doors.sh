#!/bin/bash
ZABBIX_GET='zabbix_get'

HOSTIP=$1
SO=$($ZABBIX_GET -s $HOSTIP -k system.uname)
if [[ $SO =~ .*Windows.* ]] ; then
    LIST=$($ZABBIX_GET -s $HOSTIP -k 'system.run[netstat -na]' | egrep -w 'LISTENING'| grep -v '127.0.0.1' | awk -F':' '{print $2}' | grep 0.0 | awk '{print $1}')
    echo "$LIST" | while read line; do
        echo -e "$line"      
    done
    
else
    LIST=$($ZABBIX_GET -s $HOSTIP -k 'system.run[netstat -na]' | egrep -w 'LISTEN' | awk '{print $4}' | awk -F':' '{print $NF}' | sort | uniq)
    echo "$LIST" | while read line; do
        echo -e "$line"        
    done
fi