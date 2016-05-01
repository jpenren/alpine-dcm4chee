FROM jpenren/alpine-openjdk7

ENV DCM4CHEE_VERSION 2.18.1
ENV JBOSS_VERSION 4.2.3.GA
ENV DATABASE hsql

RUN mkdir /opt/ &&\
    wget -P /tmp/ http://downloads.sourceforge.net/project/dcm4che/dcm4chee/$DCM4CHEE_VERSION/dcm4chee-$DCM4CHEE_VERSION-$DATABASE.zip &&\
    wget -P /tmp/ http://downloads.sourceforge.net/project/jboss/JBoss/JBoss-$JBOSS_VERSION/jboss-$JBOSS_VERSION.zip &&\
    unzip /tmp/dcm4chee-$DCM4CHEE_VERSION-$DATABASE.zip -d /opt/ &&\
    unzip /tmp/jboss-$JBOSS_VERSION.zip -d /tmp/ &&\
    /opt/dcm4chee-$DCM4CHEE_VERSION-$DATABASE/bin/install_jboss.sh /tmp/jboss-$JBOSS_VERSION &&\
    rm -fr /tmp/* &&\
    rm /opt/dcm4chee-$DCM4CHEE_VERSION-$DATABASE/bin/*.bat &&\
    rm /opt/dcm4chee-$DCM4CHEE_VERSION-$DATABASE/bin/native/*.dll &&\
    apk --update add imagemagick ttf-dejavu &&\
    rm -rf /var/cache/apk/*

COPY data/ /opt/dcm4chee-$DCM4CHEE_VERSION-$DATABASE/server/default/data/
COPY lib/ /opt/dcm4chee-$DCM4CHEE_VERSION-$DATABASE/server/default/lib/
COPY native/ /opt/dcm4chee-$DCM4CHEE_VERSION-$DATABASE/bin/native/

EXPOSE 8080

CMD ["sh","-c","/opt/dcm4chee-${DCM4CHEE_VERSION}-${DATABASE}/bin/run.sh"]
