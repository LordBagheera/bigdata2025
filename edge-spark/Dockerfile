FROM bdsa2025/bdsa2025-spark-hive:3.4.1

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"

HEALTHCHECK CMD netstat -an | grep 2222 > /dev/null; if [ 0 != $? ]; then exit 1; fi;

ENV FLINK_VERSION=1.18.1
ENV HADOOP_VERSION=3
ENV FLINK_HOME=/opt/flink

ENV SBT_VERSION 1.7.1
ENV SBT_URL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz
ENV SBT_HOME=/opt/sbt
ENV TZ America/Santiago
ENV ROOT_PASSWORD defaults
ENV GLOBAL_ENV_FILE /etc/profile.d/hadoop_env.sh
COPY startup.sh /usr/local/bin/

RUN set -x \
    && curl -fSL "$SBT_URL" -o /tmp/sbt.tgz \
    && tar -xvf /tmp/sbt.tgz -C /opt/ \
    && rm -rf /tmp/sbt.tgz* \
    && curl -fSL https://archive.apache.org/dist/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.12.tgz -o /tmp/flink.tgz \
    && tar -xzf /tmp/flink.tgz -C /opt/ \
    && ln -s /opt/flink-${FLINK_VERSION} ${FLINK_HOME} \
    && rm /tmp/flink.tgz \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      vim \
      nano \
      openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /var/run/sshd ; touch /var/log/sshd ; \
    cd /etc/ssh/; ssh-keygen -A ; \
    sed -i 's/^#\(Port\) .*/\1 2222/' /etc/ssh/sshd_config; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    sed -i 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config; \
    sed -i 's/^#PermitTTY no/PermitTTY yes/' /etc/ssh/sshd_config \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo "root:$ROOT_PASSWORD" | chpasswd \
    #&& export SPARK_DIST_CLASSPATH=$(hadoop classpath) \
    && chmod +x /usr/local/bin/startup.sh /usr/local/bin/entrypoint.sh ; touch $GLOBAL_ENV_FILE \ 
    && echo 'echo "export PATH=\$PATH:${FLINK_HOME}/bin:\$PATH" >> $GLOBAL_ENV_FILE'

EXPOSE 2222

ENTRYPOINT ["entrypoint.sh"]
CMD /usr/local/bin/startup.sh

