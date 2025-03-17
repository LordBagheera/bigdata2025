FROM bdsa2025/hadoop-base:3.4.1-jdk17

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"
LABEL version="0.1"

HEALTHCHECK CMD netstat -an | grep 2222 > /dev/null; if [ 0 != $? ]; then exit 1; fi;

ENV SBT_VERSION 1.7.1
ENV SBT_URL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz
ENV TZ America/Santiago
ENV ROOT_PASSWORD defaults
ENV GLOBAL_ENV_FILE /etc/profile.d/hadoop_env.sh

RUN set -x \
    && curl -fSL "$SBT_URL" -o /tmp/sbt.tgz \
    && tar -xvf /tmp/sbt.tgz -C /opt/ \
    && rm -rf /tmp/sbt.tgz*

ENV BASE_URL=https://downloads.apache.org/spark/
ENV SPARK_VERSION=3.5.5

RUN set -x \
    && curl -fSL "$BASE_URL/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-without-hadoop.tgz" -o /tmp/spark.tgz \
      && tar -xvf /tmp/spark.tgz -C /opt/ \
      && rm -rf /tmp/spark.tgz

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      vim \
      nano \
      openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd ; touch /var/log/sshd ; \
    cd /etc/ssh/; ssh-keygen -A ; \
    sed -i 's/^#\(Port\) .*/\1 2222/' /etc/ssh/sshd_config; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    sed -i 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config; \
    sed -i 's/^#PermitTTY no/PermitTTY yes/' /etc/ssh/sshd_config
    #echo 'echo "LogLevel DEBUG1" >> /etc/ssh/sshd_config'; \


RUN { \
    echo '#!/bin/bash -eux'; \
    echo 'ln -fs /usr/share/zoneinfo/$TZ /etc/localtime'; \
    echo 'echo "root:$ROOT_PASSWORD" | chpasswd'; \
    echo 'touch $GLOBAL_ENV_FILE'; \
    echo 'echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export HADOOP_VERSION=3.4.1" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export HADOOP_HOME=/opt/hadoop-\$HADOOP_VERSION" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export HADOOP_CONF_DIR=/etc/hadoop" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export MULTIHOMED_NETWORK=1" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export SBT_HOME=/opt/sbt" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export PYTHONHASHSEED=1" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export SPARK_HOME=/opt/spark-$SPARK_VERSION-bin-without-hadoop" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export PATH=\$HADOOP_HOME/bin:\$SPARK_HOME/bin:\$SBT_HOME/bin:\$PATH" >> $GLOBAL_ENV_FILE'; \
    echo 'echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> $GLOBAL_ENV_FILE'; \
    echo 'exec /usr/sbin/sshd -D -e'; \
    } >> /usr/local/bin/run_ssh_daemon.sh; \
    chmod +x /usr/local/bin/run_ssh_daemon.sh;

COPY spark-defaults.conf /spark/conf/
EXPOSE 2222

ENTRYPOINT ["/entrypoint.sh"]
CMD    ["/usr/local/bin/run_ssh_daemon.sh"]

