#!/bin/bash

export YARN_RESOURCEMANAGER_OPTS="$YARN_NODEMANAGER_OPTS --add-opens java.base/java.net=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.nio=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.util.concurrent.atomic=ALL-UNNAMED"
$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR resourcemanager