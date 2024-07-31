ARG PROCESS_SERVICES_VERSION
FROM alfresco/process-services-admin:${PROCESS_SERVICES_VERSION} AS APS
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

ENV ACTIVITI_ADMIN_PROPS ${CATALINA_HOME}/lib/activiti-admin.properties

# Copy custom entrypoint and properties
COPY --from=APS /home/alfresco/ /home/alfresco/
COPY --from=APS ${ACTIVITI_ADMIN_PROPS} ${ACTIVITI_ADMIN_PROPS}
COPY --from=APS ${CATALINA_HOME}/webapps/ ${CATALINA_HOME}/webapps/
RUN sed -i -e 's/<secure>.*<\/secure>//' ${CATALINA_HOME}/conf/web.xml

RUN wget https://jdbc.postgresql.org/download/postgresql-42.7.2.jar -O ${CATALINA_HOME}/lib/postgresql-42.7.2.jar

RUN yum remove wget -y && \
    yum autoremove -y && \
    yum clean all

RUN mkdir -p /usr/local/tomcat/work/Catalina/localhost/activiti-admin

RUN chown ${USERNAME}:${USERNAME} -R /usr/local/tomcat

# Docker layerization is procedural. This means that each directive is a layer, executed in the sequence in which it is presented.
# If a layer changes, it invalidates all subsequent layers.
# The EXPOSE, CMD and ENV layers are the ones least likely to change and they normally remain on top to reduce build time.
EXPOSE 8080

USER ${USERNAME}
CMD ["/home/alfresco/entrypoint.sh"]