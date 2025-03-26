#!/bin/bash -x

hadoop fs -mkdir       /tmp
hadoop fs -mkdir -p    /user/hive/warehouse
hadoop fs -chmod g+w   /tmp
hadoop fs -chmod g+w   /user/hive/warehouse
touch /var/log/hive/hive.log
echo $PATH
/etc/init.d/mariadb start
hiveserver2 --service metastore &
hiveserver2 --service hiveserver2 &
tail -f /var/log/hive/hive.log

