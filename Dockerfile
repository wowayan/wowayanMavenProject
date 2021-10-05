FROM jboss/wildfly

MAINTAINER Ayan Biswas thats4ayan@gmail.com

ADD target/samplewar.war /opt/jboss/wildfly/standalone/deployments

RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "0.0.0.0", -bmanagement " , "0.0.0.0 " ]

