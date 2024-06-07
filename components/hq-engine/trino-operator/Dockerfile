FROM trinodb/trino:449

LABEL maintainer="Duy Nguyen <duynguyenngoc@hotmail.com>"

WORKDIR /
USER root

RUN mkdir -p /etc/trino/kafka
RUN chmod 755 /etc/trino/kafka
RUN chown -R trino:trino /etc/trino/kafka

COPY ./auth/password.db /etc/trino/password.db
RUN chown trino:trino /etc/trino/password.db

COPY ./auth/presto_keystore.jks /etc/trino/presto_keystore.jks
RUN chown trino:trino /etc/trino/presto_keystore.jks

COPY ./auth/password-authenticator.properties /etc/trino/password-authenticator.properties
RUN chown trino:trino /etc/trino/password-authenticator.properties

RUN chown trino:trino /
COPY ./run.sh /run.sh
RUN chmod +x /run.sh

USER trino:trino

EXPOSE 8080