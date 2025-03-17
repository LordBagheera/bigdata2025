#!/bin/bash

datadir=`echo $HDFS_CONF_dfs_datanode_data_dir | perl -pe 's#file://##'`
if [ ! -d $datadir ]; then
  echo "Datanode data directory not found: $datadir"
  exit 2
fi

export YARN_DATANODE_OPTS="$YARN_DATANODE_OPTS --add-opens java.base/java.lang=ALL-UNNAMED"
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR datanode