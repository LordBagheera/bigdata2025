FROM bdsa2025/bdsa2025-base:3.4.1

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"

ENV HIVE_VERSION=2.3.9
ENV HIVE_URL https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
#ENV HIVE_CORE_CONF_javax_jdo_option_ConnectionURL jdbc:postgresql://hive-metastore/metastore

RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
    && mkdir /var/log/hive \
    && rm /tmp/hive.tar.gz* \
    && ln -s /opt/apache-hive-$HIVE_VERSION-bin/conf /etc/hive

ENV HIVE_HOME=/opt/apache-hive-$HIVE_VERSION-bin
ENV HIVE_CONF_DIR=/etc/hive/
ENV PATH $HIVE_HOME/bin:$PATH

COPY create-user.sql /
#COPY hive-4.0.0-schema.sql /
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    postgresql \
    libpostgresql-jdbc-java \
    && rm -rf /var/lib/apt/lists/* ; \
    #chown mysql:mysql /var/lib/mysql ; \
    ln -s /usr/share/java/postgresql-jdbc4.jar /opt/apache-hive-$HIVE_VERSION-bin/lib/  ; \
    cp $HIVE_CONF_DIR/hive-log4j2.properties.template $HIVE_CONF_DIR/hive-log4j2.properties 
    ##cp $HIVE_CONF_DIR/hive-default.xml.template $HIVE_CONF_DIR/hive-site.xml

RUN /etc/init.d/postgresql start; \
    ##sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf; \
    sed -i "s/^#listen_addresses = 'localhost'.*/listen_addresses = '*'/" /etc/postgresql/15/main/postgresql.conf ; \
    echo "host    all       all       0.0.0.0/0         scram-sha-256" | tee -a /etc/postgresql/15/main/pg_hba.conf ; \
    rm /opt/apache-hive-$HIVE_VERSION-bin/lib/postgresql-9.4.1208.jre7.jar ; \
    ##sed -i 's/INFO/DEBUG/' $HIVE_CONF_DIR/hive-log4j2.properties; \
    su postgres -c 'psql -f create-user.sql'; \
    #ls /opt/apache-hive-$HIVE_VERSION-bin/scripts/metastore/upgrade/mysql/ ; \
    cd /opt/apache-hive-$HIVE_VERSION-bin/scripts/metastore/upgrade/postgres/ ; \
    PGPASSWORD='hive' psql -U hive -d metastore -h localhost -f hive-schema-2.3.0.postgres.sql

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

