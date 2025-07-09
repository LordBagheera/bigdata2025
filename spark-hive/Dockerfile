FROM bdsa2025/bdsa2025-base:3.4.1

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"

ENV BASE_URL=https://downloads.apache.org/spark
ENV SPARK_VERSION=3.5.6
ENV HIVE_VERSION=2.3.9
ENV HIVE_URL https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
ENV HIVE_HOME=/opt/apache-hive-$HIVE_VERSION-bin
ENV HIVE_CONF_DIR=/etc/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HIVE_CONF_DIR=/etc/hive
ENV SBT_HOME=/opt/sbt
ENV PYTHONHASHSEED=1
ENV SPARK_HOME=/opt/spark-$SPARK_VERSION-bin-hadoop3-scala2.13
ENV SPARK_CONF_DIR=$HADOOP_CONF_DIR
ENV PATH=$HADOOP_HOME/bin:$SPARK_HOME/bin:$SBT_HOME/bin:$PATH

RUN set -x \
    && curl -fSL "$BASE_URL/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3-scala2.13.tgz" -o /tmp/spark.tgz \
    && tar -xvf /tmp/spark.tgz -C /opt/ \
    && rm -rf /tmp/spark.tgz \
    && ln -s /opt/spark-$SPARK_VERSION-bin-hadoop3-scala2.13 /opt/spark \
    && set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
    && mkdir /var/log/hive \
    && rm /tmp/hive.tar.gz* \
    && ln -s /opt/apache-hive-$HIVE_VERSION-bin/conf /etc/hive \
    && cp $HIVE_CONF_DIR/hive-log4j2.properties.template $HIVE_CONF_DIR/hive-log4j2.properties 

# RUN export SPARK_DIST_CLASSPATH=$(hadoop classpath)

COPY spark-defaults.conf $HADOOP_CONF_DIR
COPY beeline-hs2-connection.xml /etc/hive/
COPY hive-site.xml /etc/hive/
COPY entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["entrypoint.sh"]