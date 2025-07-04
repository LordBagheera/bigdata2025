FROM bdsa2025/bdsa2025-spark-hive:3.4.1

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"


HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]