FROM fs-pcm-docker.maven.etb.tieto.com/tieto/pcm-ansible:latest
COPY ansible /ansible/playbooks/ansible
RUN chmod -R ugo+rw /ansible/playbooks
WORKDIR /ansible/playbooks