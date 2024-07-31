ARG PROCESS_SERVICES_VERSION
FROM alfresco/process-services:${PROCESS_SERVICES_VERSION} AS APS
FROM alfresco/alfresco-base-tomcat:tomcat10-jre17-rockylinux9

ARG USERNAME=alfresco
ARG USERID=33007

USER root

RUN set -x \
   && useradd \
        -c "Alfresco APS" \
        -M \
        -s "/bin/bash" \
        -u "${USERID}" \
        -o \
        "${USERNAME}" \
   && yum update -y \
   && yum install -y \
      unzip \
      wget \
      openssl \
      fontconfig dejavu-sans-fonts

ENV ACTIVITI_APP_PROPS ${CATALINA_HOME}/lib/activiti-app.properties
ENV ACTIVITI_IDENTITY_SERVICE_PROPS ${CATALINA_HOME}/lib/activiti-identity-service.properties

# Copy custom entrypoint and properties
COPY --from=APS /home/alfresco/ /home/alfresco/
COPY --from=APS ${ACTIVITI_APP_PROPS} ${ACTIVITI_APP_PROPS}
COPY --from=APS ${ACTIVITI_IDENTITY_SERVICE_PROPS} ${ACTIVITI_IDENTITY_SERVICE_PROPS}
COPY --from=APS ${CATALINA_HOME}/webapps/ ${CATALINA_HOME}/webapps/
RUN sed -i -e 's/<secure>.*<\/secure>//' ${CATALINA_HOME}/conf/web.xml

RUN wget https://jdbc.postgresql.org/download/postgresql-42.7.2.jar -O ${CATALINA_HOME}/lib/postgresql-42.7.2.jar

WORKDIR ${CATALINA_HOME}/webapps/

RUN yum remove wget -y && \
    yum autoremove -y && \
    yum clean all

RUN mkdir /usr/local/data && chown ${USERNAME}:${USERNAME} -R /usr/local/data

RUN mkdir -p /usr/local/tomcat/work/Catalina/localhost/activiti-app

RUN chown ${USERNAME}:${USERNAME} -R /usr/local/tomcat

# Docker layerization is procedural. This means that each directive is a layer, executed in the sequence in which it is presented.
# If a layer changes, it invalidates all subsequent layers.
# The EXPOSE, CMD and ENV layers are the ones least likely to change and they normally remain on top to reduce build time.
EXPOSE 8080

USER ${USERNAME}
CMD ["/home/alfresco/entrypoint.sh"]