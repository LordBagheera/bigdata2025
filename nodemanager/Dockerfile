FROM bdsa2025/hadoop-base:3.4.1-jdk17

LABEL authors="Erik Hurtado <erik.hurtado@inacapmail.cl>"
LABEL title="BDSA - Big Data South America - Inspired on BDE2020"
LABEL version="0.1"

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]