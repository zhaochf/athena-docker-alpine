FROM zhaochf/athena-alpine-jdk8:1.0
MAINTAINER zhaochf <zhaochf@aliyun.com>

ENV ZOO_CONF_DIR=/data/app/apache-zookeeper-3.6.2/conf \
    ZOO_DATA_DIR=/data/app/apache-zookeeper-3.6.2/data \
    ZOO_DATA_LOG_DIR=/data/app/apache-zookeeper-3.6.2/datalog \
    ZOO_LOG_DIR=/data/app/apache-zookeeper-3.6.2/logs \
    ZOO_TICK_TIME=2000 \
    ZOO_INIT_LIMIT=5 \
    ZOO_SYNC_LIMIT=2 \
    ZOO_AUTOPURGE_PURGEINTERVAL=0 \
    ZOO_AUTOPURGE_SNAPRETAINCOUNT=3 \
    ZOO_MAX_CLIENT_CNXNS=60 \
    ZOO_STANDALONE_ENABLED=true \
    ZOO_ADMINSERVER_ENABLED=true


ADD apache-zookeeper-3.6.2-bin.tar.gz /data/app/
COPY docker-entrypoint.sh /data/app/apache-zookeeper-3.6.2-bin/bin

RUN set -eux; \
    addgroup --gid=1000 -S zookeeper; \
    adduser -S -G zookeeper --uid=1000 zookeeper; \
    mv /data/app/apache-zookeeper-3.6.2-bin /data/app/apache-zookeeper-3.6.2; \
    mkdir -p "$ZOO_DATA_LOG_DIR" "$ZOO_DATA_DIR" "$ZOO_LOG_DIR"; \
    chown -R zookeeper:zookeeper /data/app/apache-zookeeper-3.6.2

VOLUME ["$ZOO_DATA_DIR", "$ZOO_DATA_LOG_DIR", "$ZOO_LOG_DIR"]

EXPOSE 2181 2888 3888 8080

ENV PATH=$PATH:/data/app/apache-zookeeper-3.6.2/bin \
    ZOOCFGDIR=$ZOO_CONF_DIR

ENTRYPOINT ["/data/app/apache-zookeeper-3.6.2/bin/docker-entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]