from openjdk:8-jre

RUN mkdir -p /opt \
  && curl --fail --silent --location --retry 3 \
  https://www-eu.apache.org/dist/flume/1.9.0/apache-flume-1.9.0-bin.tar.gz \
  | gunzip \
  | tar -x -C /opt \
  && mv /opt/apache-flume-1.9.0-bin /opt/flume

EXPOSE 41414

WORKDIR /opt

COPY flume-env.sh /opt/flume/conf/flume-env.sh

CMD ["/bin/bash", "-c", "/opt/flume/bin/flume-ng agent -n agent1 -Dflume.monitoring.type=http -Dflume.root.logger=INFO,console -c /opt/flume/conf -f /opt/flume/conf/flume.conf"]
