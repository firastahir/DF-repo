FROM openshift/rhel7:latest

MAINTAINER firas.taher@bestbuy.com

ENV PATH="/opt/yantra/yntadmin/java/java/bin:/opt/yantra/eoprt01/smcfs93local/bin:${PATH}" \
    JAVA_HOME="/opt/yantra/yntadmin/java" \
    KEYSTORE_FILE=/opt/yantra/yntadmin/SSL/appclient_oms.jks \
    KEYSTORE_PASS_PHRASE_FILE=/opt/yantra/yntadmin/SSL/appclient_pass_oms \
    TRUSTSTORE_FILE=/opt/yantra/yntadmin/SSL/was_truststore_oms.jks \
    TRUSTSTORE_PASS_PHRASE_FILE=/opt/yantra/yntadmin/SSL/was_truststore_pass_oms \
    IBM_JAVACOREDIR=/opt/logs/yantra/eoprt01/dump

COPY smcfs93local_qa01.tar SSL.zip /opt/

RUN  yum update -y \
  && yum install -y \ 
     java-11-openjdk-devel.x86_64 \ 
     net-tools \
     bind-utils \
     telnet \
     iputils \ 
     lsof \
     curl \
     unzip \
  && yum clean all \
  && mkdir -p \ 
      /opt/yantra/yntadmin/java/ \
      /opt/logs/yantra/eoprt01/dump/ \
      /opt/yantra/eoprt01/smcfs93local/tmp/ehcache/ \
  && tar -xvf /opt/smcfs93local_qa01.tar -C /opt/yantra/eoprt01/ \
  && unzip /opt/SSL.zip -d /opt/yantra/yntadmin/ \
  && chmod -R 777 /opt/ 


WORKDIR /opt/yantra/eoprt01/smcfs93local

EXPOSE 59506

CMD ["sh", "-c", "for (( ; ; )); do sleep 1; done"]