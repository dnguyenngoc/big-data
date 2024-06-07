FROM openjdk:11-jre

LABEL maintainer="Duy Nguyen <duynguyenngoc@hotmail.com>"

WORKDIR /opt

ENV HADOOP_VERSION=3.3.3
ENV HIVE_METASTORE_VERSION=3.0.0

ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_HOME=/opt/hive

# install hive
RUN wget -O apache-hive.tgz https://apache.org/dist/hive/hive-standalone-metastore-${HIVE_METASTORE_VERSION}/hive-standalone-metastore-${HIVE_METASTORE_VERSION}-bin.tar.gz \
    && mkdir -p /opt/hive \
    && tar -xf apache-hive.tgz -C /opt/hive --strip-components=1 \
    && rm -rf apache-hive.tgz

# install hadoop
RUN wget -O apache-hadoop.tgz \
    https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && mkdir -p /opt/hadoop \
    && tar -xf apache-hadoop.tgz -C /opt/hadoop --strip-components=1 \
    && rm -rf apache-hadoop.tgz

# Install Python
RUN apt-get update && apt-get install -y python3 python3-pip procps

# install jar needed
RUN wget -q -P /opt/hadoop/share/hadoop/tools/lib/ https://jdbc.postgresql.org/download/postgresql-42.7.3.jar
RUN wget -q -P /opt/hadoop/share/hadoop/tools/lib/ https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar

RUN apt-get install curl -y

RUN curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz | tar zxf - && \
    cp mysql-connector-java-8.0.19/mysql-connector-java-8.0.19.jar /opt/hadoop/share/hadoop/tools/lib/ && \
    rm -rf  mysql-connector-java-8.0.19

COPY conf/metastore-site.xml ${HIVE_HOME}/conf
COPY scripts/* /

RUN chmod +x /run.sh \
    && chmod +x /add-config.py

EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/run.sh"]
