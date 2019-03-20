FROM ansible/centos7-ansible:stable
COPY ansible /ansible/playbooks/ansible
RUN chmod -R ugo+rw /ansible/playbooks
WORKDIR /ansible/playbooks
