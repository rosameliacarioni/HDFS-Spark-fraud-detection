#!/usr/bin/env bash

echo "start-hadoop.sh"

# Check user environment variable
if [[ -z "${HDFS_USER}" ]]; then
  echo "Missing HDFS_USER environment variable" >&2
  exit 1
fi
# Set HADOOP_USER_NAME environment vairable
HADOOP_USER_NAME="${HDFS_USER}"
echo "export  HADOOP_USER_NAME=\"${HDFS_USER}\"" >> /etc/bash.bashrc
# Create user for HDFS
adduser --no-create-home --disabled-password --gecos "" $HDFS_USER
# Fix directory permissions
if ! [[ $(whoami) = $HDFS_USER ]]; then
  find /opt/hdfs ! -user $HDFS_USER -print0 | xargs -0 chown $HDFS_USER:$HDFS_USER \
      > /dev/null 2>&1 ;
  find $HADOOP_HOME ! -user $HDFS_USER -print0 | xargs -0 chown $HDFS_USER:$HDFS_USER \
      > /dev/null 2>&1 ;
else
  echo "\$HDFS_USER is root"
fi

echo "User $HDFS_USER created"

# Select node type
if [[ "${1}" = 'namenode' ]]; then
  su $HDFS_USER -c "/opt/util/bin/start-hadoop-namenode $2"
elif [[ "${1}" =  'datanode' ]]; then
  su $HDFS_USER -c "/opt/util/bin/start-hadoop-datanode $2"
else
  echo "Invalid command '${1}'" >&2
  exit 1
fi