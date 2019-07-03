#!/usr/bin/env python

from pyzabbix import ZabbixAPI
import sys

apiUrl = 'http://172.17.0.1'
apiUser = 'api_integration'
apiPass = 'EtZtfXSp33Tyca4b'

zapi = ZabbixAPI(url=apiUrl, user=apiUser, password=apiPass)
hostname = sys.argv[1]

f  = {  'host' : hostname  }
get = zapi.host.get(filter=f, output=['hostids'] )
hostId = get[0]['hostid']

def get_all_events():
    triggers = zapi.trigger.get (
        hostids = hostId,
        only_true = 1,
        monitored = 1,
        active = 1
        )
    return triggers

def count():
    count = len(get_all_events())
    print(count)

count()