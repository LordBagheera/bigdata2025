FROM debian:12.10

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-17-jdk \
      net-tools \
      curl \
      netcat-traditional \
      gnupg \
      libsnappy-dev \
      python3 \
      python3-pip \
      vim \
      procps \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS && rm KEYS

ENV HADOOP_VERSION 3.4.1
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz* \
    && ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop \
    && mkdir /opt/hadoop-$HADOOP_VERSION/logs \
    && mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV HADOOP_CLASSPATH=/etc/hadoop:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/common/lib/*:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/common/*:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/hdfs:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/hdfs/lib/*:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/hdfs/*:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/mapreduce/*:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn/lib/*:/opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn/*
ENV PATH=$HADOOP_HOME/bin:$HADOOP_CLASSPATH:$PATH

COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]