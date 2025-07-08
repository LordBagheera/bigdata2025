#!/bin/bash -x

hadoop fs -mkdir       /tmp
hadoop fs -mkdir -p    /user/hive/warehouse
hadoop fs -chmod g+w   /tmp
hadoop fs -chmod g+w   /user/hive/warehouse

touch /var/log/hive/hive.log
/etc/init.d/postgresql start
hiveserver2 --service metastore &
hiveserver2 --service hiveserver2 &
tail -f /var/log/hive/hive.log

