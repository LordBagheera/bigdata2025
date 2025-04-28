#!/bin/bash

export YARN_NODEMANAGER_OPTS="$YARN_NODEMANAGER_OPTS --add-opens java.base/java.lang=ALL-UNNAMED"
$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR nodemanager