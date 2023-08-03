# Use an official Python runtime as the base image
FROM python:3.11.3-slim-bullseye

# Set the working directory in the container
WORKDIR /app

# Create a new user and group with UID/GID 1000
RUN groupadd -g 1000 apot && \
    useradd -u 1000 -g apot -s /bin/bash apot

# Create a writable directory for JupyterLab extensions under /home/apot
RUN mkdir -p /home/apot/.local/share/jupyter/lab/extensions && \
    chown -R apot:apot /home/apot/.local

# setup java
RUN apt-get update && apt-get install -y openjdk-11-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Install necessary packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      net-tools \
      curl \
      netcat \
      gnupg \
      libsnappy-dev \
    && rm -rf /var/lib/apt/lists/*

# Import Hadoop signing keys
RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS
RUN gpg --import KEYS

# Download and install Hadoop
ENV HADOOP_VERSION 3.3.1
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

# Create symlinks and directories
RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs
RUN mkdir /hadoop-data

# Set Hadoop environment variables
ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin/:$PATH

# Install Spark
ENV SPARK_VERSION 3.3.1
ENV SPARK_URL https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3.tgz

RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz \
    && tar -xvf /tmp/spark.tar.gz -C /opt/ \
    && rm /tmp/spark.tar.gz*

# Create symlink for Spark
RUN ln -s /opt/spark-$SPARK_VERSION-bin-hadoop3 /opt/spark

# Set Spark environment variables
ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin/:$PATH

# Install JupyterLab and other required dependencies as root
RUN pip install --no-cache-dir jupyterlab

# # Install Jupyter Scala kernel (almond)
# RUN coursier bootstrap \
#     --quiet \
#     --standalone \
#     --scala 2.12.14 \
#     --main almond.Main \
#     --output /usr/local/bin/almond && \
#     chmod +x /usr/local/bin/almond && \
#     /usr/local/bin/almond --install --global --force

# # Install JupyterLab Scala extension
# RUN jupyter labextension install jupyterlab-scala

# Switch to the new user
USER apot

# Copy the Jupyter configuration file
COPY jupyter_server_config.json /home/apot/.jupyter/jupyter_server_config.json

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

RUN pip install pycountry pillow matplotlib
# Expose the JupyterLab port
EXPOSE 8888

# Start JupyterLab when the container is launched
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
