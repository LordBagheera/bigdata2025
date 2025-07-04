FROM bdsa2025/hadoop-base:3.4.1_java-17

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"

ENV HIVE_VERSION=4.0.1
ENV HIVE_URL https://downloads.apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
ENV HIVE_CORE_CONF_javax_jdo_option_ConnectionURL jdbc:postgresql://hive-metastore/metastore

RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
    && mkdir /var/log/hive \
    && rm /tmp/hive.tar.gz*

RUN ln -s /opt/apache-hive-$HIVE_VERSION-bin/conf /etc/hive

ENV HIVE_HOME=/opt/apache-hive-$HIVE_VERSION-bin
ENV HIVE_CONF_DIR=/etc/hive/
ENV PATH $HIVE_HOME/bin:$PATH

COPY create-user.sql /
COPY hive-4.0.0-schema.sql /
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    mariadb-server \
    libmariadb-java \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/* ; \
    chown mysql:mysql /var/lib/mysql ; \
    ln -s /usr/share/java/mariadb-java-client.jar /opt/apache-hive-$HIVE_VERSION-bin/lib/  ; \
    cp $HIVE_CONF_DIR/hive-log4j2.properties.template $HIVE_CONF_DIR/hive-log4j2.properties



RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf; \
    ##sed -i 's/INFO/DEBUG/' $HIVE_CONF_DIR/hive-log4j2.properties; \
    /etc/init.d/mariadb start; \
    mysql -u root < create-user.sql; \
    mysql -u root < hive-4.0.0-schema.sql

COPY hive-site.xml /etc/hive/
COPY beeline-hs2-connection.xml /etc/hive/
COPY startup.sh /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh ; chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 10000
EXPOSE 10002
EXPOSE 3306
EXPOSE 9083
EXPOSE 8080

ENTRYPOINT ["entrypoint.sh"]
CMD /usr/local/bin/startup.sh

