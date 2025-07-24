FROM  alpine
LABEL Maintainer="Erik Hurtado"
LABEL Email="hurtado.erik@gmail.com"
LABEL Description="Nifi, based on alpine linux"

RUN apk add --no-cache bash openssh sed vim openjdk17 zip tar ca-certificates
ENV USER root 
ENV PASSWORD ThisIsAnUnS3cur3P4ssw0rd
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk
ENV PATH $JAVA_HOME/bin:$PATH
ENV NIFI_HOME /opt/nifi
ENV NIFI_VERSION 1.28.1

RUN wget https://archive.apache.org/dist/nifi/$NIFI_VERSION/nifi-$NIFI_VERSION-bin.zip -O /opt/nifi.zip ; \
    cd /opt ; \
    unzip nifi.zip ; \
    ln -s nifi-$NIFI_VERSION nifi
RUN mkdir $NIFI_HOME/database_repository && \
    mkdir $NIFI_HOME/flowfile_repository && \
    mkdir $NIFI_HOME/content_repository && \
    mkdir $NIFI_HOME/provenance_repository && \
    mkdir $NIFI_HOME/xsl && \
    mkdir $NIFI_HOME/extra_lib && \
    sed -i 's/127.0.0.1/0.0.0.0/' ${NIFI_HOME}/conf/nifi.properties ; \
    sed -i 's|http/1.1|h2|' ${NIFI_HOME}/conf/nifi.properties ; \
    ${NIFI_HOME}/bin/nifi.sh set-single-user-credentials ${USER} ${PASSWORD} ; \
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -q

VOLUME ["$NIFI_HOME/conf", "$NIFI_HOME/database_repository", "$NIFI_HOME/flowfile_repository", "$NIFI_HOME/content_repository", "$NIFI_HOME/provenance_repository", "$NIFI_HOME/extra_lib"]

EXPOSE 8443
WORKDIR ${NIFI_HOME}
CMD ["bin/nifi.sh", "run"]
