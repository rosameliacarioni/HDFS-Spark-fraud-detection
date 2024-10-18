FROM ubuntu:latest

ENV HADOOP_VERSION=3.2.4
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Set paths
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop \
  HADOOP_LIBEXEC_DIR=$HADOOP_HOME/libexec

# HDFS volume
VOLUME /opt/hdfs

# Install hadoop
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk wget net-tools ssh

# Create hadoop home directory
RUN mkdir -p /opt/hadoop-${HADOOP_VERSION}

# Copy hadoop-3.2.4.tar.gz if you have it locally
# COPY hadoop-${HADOOP_VERSION}.tar.gz /tmp/hadoop-${HADOOP_VERSION}.tar.gz
# Download hadoop (slow)
RUN wget https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -P /tmp;

# Extract hadoop
RUN tar -xvzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/hadoop-${HADOOP_VERSION} --strip-components=1

# Keep container running for debugging
# CMD tail -f /dev/null


# Copy start scripts
COPY start-hadoop.sh /opt/util/bin/start-hadoop
COPY start-hadoop-namenode.sh /opt/util/bin/start-hadoop-namenode
COPY start-hadoop-datanode.sh /opt/util/bin/start-hadoop-datanode

# Fix permissions
RUN chmod +x /opt/util/bin/start-hadoop
RUN chmod +x /opt/util/bin/start-hadoop-namenode
RUN chmod +x /opt/util/bin/start-hadoop-datanode

# Fix line endings
RUN sed -i 's/\r$//' /opt/util/bin/start-hadoop
RUN sed -i 's/\r$//' /opt/util/bin/start-hadoop-namenode
RUN sed -i 's/\r$//' /opt/util/bin/start-hadoop-datanode

# Set paths
ENV PATH=$PATH:/opt/util/bin
ENV PATH $HADOOP_HOME/bin/:$PATH
ENV PATH $HADOOP_HOME/sbin/:$PATH

# Fix environment for other users
RUN echo "export HADOOP_HOME=$HADOOP_HOME" > /etc/bash.bashrc.tmp \
  && echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:/opt/util/bin'>> /etc/bash.bashrc.tmp \
  && cat /etc/bash.bashrc >> /etc/bash.bashrc.tmp \
  && mv -f /etc/bash.bashrc.tmp /etc/bash.bashrc

# Create symbolic link from the concrete hadoop version to /opt/hadoop
RUN ln -s $HADOOP_HOME /opt/hadoop

# Expose ports
EXPOSE 8020 9870 9864