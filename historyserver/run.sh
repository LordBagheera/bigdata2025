#!/bin/bash

export YARN_HISTORYSERVER_OPTS="$YARN_HISTORYSERVER_OPTS --add-opens java.base/java.lang=ALL-UNNAMED"
$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR historyserver