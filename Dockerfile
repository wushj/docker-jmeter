FROM ubuntu:16.04


ENV JMETER_VERSION 5.0
ENV JMETER_HOME /usr/local/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN $JMETER_HOME/bin
ENV IP 0.0.0.0
ENV RMI_PORT 1099
ENV JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

RUN apt-get -qq update && \
    apt-get -yqq install openjdk-8-jdk unzip && \
    apt-get -q clean && \
    rm -rf /var/lib/apt/lists/*

COPY dependencies /tmp/dependencies

RUN tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /usr/local && \
    echo "server.rmi.ssl.disable=true" >>/usr/local/apache-jmeter-${JMETER_VERSION}/bin/jmeter.properties && \
    rm -rf /tmp/dependencies

ENV PATH $PATH:$JMETER_BIN

WORKDIR $JMETER_HOME

EXPOSE $RMI_PORT

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

