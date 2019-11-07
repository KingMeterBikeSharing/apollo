
FROM java:8

MAINTAINER CrazyAndy <auden.sh@163.com>

COPY target/apollo-adminservice-1.6.0-SNAPSHOT.jar /apollo-adminservice-1.6.0-SNAPSHOT.jar


EXPOSE 5004

ENV JAVA_OPTS="-server \
-Xms300m \
-Dsun.net.inetaddr.ttl=3 \
-Dsun.net.inetaddr.negative.ttl=1 \
-Duser.timezone=GMT+08 \
-Dapollo.meta=http://47.92.38.164:5003"

ENTRYPOINT ["java","-jar","/apollo-adminservice-1.6.0-SNAPSHOT.jar"]