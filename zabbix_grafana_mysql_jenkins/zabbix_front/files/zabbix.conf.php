<?php
// Zabbix GUI configuration file.
global $DB;

$DB['TYPE']     = 'MYSQL';
$DB['SERVER']   = '172.6.0.1';
$DB['PORT']     = '3306';
$DB['DATABASE'] = 'zabbix';
$DB['USER']     = 'zabbix';
$DB['PASSWORD'] = '@HMc37Lwz44';

$ZBX_SERVER      = 'zabbix_server';
$ZBX_SERVER_PORT = '10051';
$ZBX_SERVER_NAME = 'wt';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;