FROM manageiq/ansible-tower
MAINTAINER ManageIQ https://github.com/ManageIQ

ARG REF=master

ENV TERM=xterm

## Atomic/OpenShift Labels
LABEL name="manageiq-embedded-ansible" \
      vendor="ManageIQ" \
      version="Master" \
      release=${REF} \
      url="http://manageiq.org/" \
      summary="ManageIQ Embedded Ansible Image" \
      description="Embedded Ansible running as a container." \
      io.k8s.display-name="ManageIQ Embedded Ansible" \
      io.openshift.expose-services="443:https" \
      io.openshift.tags="Ansible,ManageIQ"

RUN yum -y remove ansible-tower-ui
RUN yum -y install --setopt=tsflags=nodocs sudo && yum clean all

COPY docker-assets/initialize-tower.sh /usr/bin
