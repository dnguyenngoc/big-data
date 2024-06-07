#!/bin/sh
HADOOP_TOOLS_DIR="${HADOOP_HOME}/share/hadoop/tools/lib"
POSTGRESQL_JAR="${HADOOP_TOOLS_DIR}/postgresql-42.7.3.jar"
MYSQL_JAR="${HADOOP_TOOLS_DIR}/mysql-connector-java-8.0.19.jar"
AWS_SDK_BUNDLE_JAR="${HADOOP_TOOLS_DIR}/aws-java-sdk-bundle-1.11.1026.jar"
HADOOP_AWS_JAR="${HADOOP_TOOLS_DIR}/hadoop-aws-3.3.3.jar"

export HADOOP_CLASSPATH="${POSTGRESQL_JAR}:${AWS_SDK_BUNDLE_JAR}:${HADOOP_AWS_JAR}:${MYSQL_JAR}"

python3 /add-config.py



/opt/hive/bin/schematool -initSchema -dbType mysql -info

if [ $? -eq 1 ]; then
  echo "Getting schema info failed. Probably not initialized. Initializing..."
  /opt/hive/bin/schematool -initSchema -dbType mysql
fi

/opt/hive/bin/start-metastore