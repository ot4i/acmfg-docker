#The below example is with ACE Base Image of 12.0.5.0-r4 . Docker image of latest ACE fixpacks can be obtained from 
#https://www.ibm.com/docs/en/app-connect/12.0?topic=cacerid-building-sample-supported-app-connect-enterprise-image-using-docker

FROM cp.icr.io/cp/appc/ace:12.0.5.0-r4

USER root	

#We need this because ACMfg installer need to create the links folder
RUN mkdir /opt/ibm/ace-12/tools

#Install ACMfg using latest installer.
ADD ACMfg_linux_amd64_3.0.1.1.tar.gz /opt/IBM
RUN /opt/IBM/ACMfg-3.0.1.1/ACMfg_install.sh /opt/ibm/ace-12 accept license silently

ENV LICENSE=accept

COPY *.bar /tmp
RUN chmod -R ugo+rwx /home/aceuser/ 

#Run in advanced mode only
RUN source /opt/ibm/ace-12/server/bin/mqsiprofile

#Copy startup.sh file
COPY startup.sh /usr/local/bin
RUN chmod 777 /usr/local/bin/startup.sh

#RUN groupadd -r aceuser && useradd -r -g aceuser aceuser
#RUN useradd -ms /bin/bash aceuser 

USER aceuser

WORKDIR  /home/aceuser

RUN mkdir /home/aceuser/initial-config \
    && mkdir /home/aceuser/initial-config/serverconf \
    && chown -R aceuser:aceuser /home/aceuser/initial-config
COPY server.conf.yaml /home/aceuser/initial-config/serverconf

# Default command to run
ENTRYPOINT ["/usr/local/bin/startup.sh" ]