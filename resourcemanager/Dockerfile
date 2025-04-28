FROM bdsa2025/hadoop-spark-hive:3.4.1_java-17_3.5.5_4.0.1

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"
LABEL version="0.1"

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]