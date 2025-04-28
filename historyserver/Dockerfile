FROM bdsa2025/hadoop-base:3.4.1_java-17

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"
LABEL version="0.1"

HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1

ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline
RUN mkdir -p /hadoop/yarn/timeline
VOLUME /hadoop/yarn/timeline

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8188

CMD ["/run.sh"]