FROM ubuntu
LABEL maintainer="Julian Nonino <noninojulian@gmail.com>"

# Install required tools, tar, curl and Java JRE
RUN apt-get update -y && \
    apt-get install -y tar curl openjdk-8-jre-headless net-tools iproute python3 python3-setuptools python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Spark
ENV SPARK_VERSION 2.4.3
ENV HADOOP_VERSION 2.7

RUN curl -O https://www.apache.org/dyn/closer.lua/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    tar -xvf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    rm -rf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION spark && \
    mv spark /opt && \
    cp /opt/spark/conf/log4j.properties.template /opt/spark/conf/log4j.properties
ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$SPARK_HOME/sbin:$SPARK_HOME/jars:$PATH
WORKDIR /opt/spark