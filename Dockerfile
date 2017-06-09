FROM carbonin/ansible-tower
MAINTAINER ManageIQ https://github.com/ManageIQ

ARG REF=master

ENV TERM=xterm

## Atomic/OpenShift Labels
LABEL name="manageiq-ansible" \
      vendor="ManageIQ" \
      version="Master" \
      release=${REF} \
      url="http://manageiq.org/" \
      summary="ManageIQ Ansible Image" \
      description="Ansible running as a container." \
      io.k8s.display-name="ManageIQ Ansible" \
      description="Ansible running as a container." \
      io.openshift.expose-services="443:https" \
      io.openshift.tags="Ansible,ManageIQ"

RUN yum -y remove ansible-tower-ui

COPY docker-assets/initialize-tower.sh /usr/bin
