FROM bdsa2025/bdsa2025-base:3.4.1

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"

HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1
ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline
VOLUME /hadoop/yarn/timeline

RUN mkdir -p /hadoop/yarn/timeline

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8188

CMD ["/run.sh"]