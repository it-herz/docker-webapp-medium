FROM itherz/webapp-tiny:d7

RUN  apt-get update && \
     rm /tmp/*.deb && cd /tmp && \
     apt-get install -y openssh-server git npm \
             && mkdir -p /var/run/sshd && \
     umask 002 && \
     sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/ig' /etc/ssh/sshd_config && \
     sed -i 's/#RSAAuthentication.*/RSAAuthentication yes/ig' /etc/ssh/sshd_config && \
     npm install -g bower && \
     # Dirty hack to share envs for ssh
     sed -i '1s/^/mkdir -p \/var\/www\/html\/.ssh \&\& env | grep _ >> \/var\/www\/html\/.ssh\/environment\n/' /root/rc && \
     sed -i 's/#\(PermitUserEnvironment\) no/\1 yes/g' /etc/ssh/sshd_config

ADD supervisord.conf /etc/
ADD 02-applykey /etc/container-run.d/

EXPOSE 22

VOLUME /var/www/html
