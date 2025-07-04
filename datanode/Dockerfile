FROM bdsa2025/bdsa2025-base:3.4.1

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1
ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
VOLUME /hadoop/dfs/data
ADD run.sh /run.sh

RUN mkdir -p /hadoop/dfs/data \
    && chmod a+x /run.sh

EXPOSE 9864

CMD ["/run.sh"]